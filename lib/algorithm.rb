module Merkle
  module Algorithm
    class << self
      def merkle_tree(array, digest, &block)
        # Define it here since we have to add &block and digest params to every method call (DRY..)
        merkle_tree_method = -> (arg) { merkle_tree(arg, digest, &block) }

        case array.size
        when 1
          return array.first
        when 2
          # This yeild for define audit_proof method. To build audit_proof_elements
          # we have to know pair of <searching> elements, so case array.size = 2 is what actually need.
          # Basicly we just need to handle this case and we will have a new audit_proof algorithm!
          yield(array) if block_given?

          return node_hash(digest, array.first, array.last)
        else
          cons = array.size.even? ? 2 : 1

          merkle_tree_method.call(
            [
              merkle_tree_method.call(array[0...(array.size - cons)]),
              merkle_tree_method.call(array[(array.size - cons)..])
            ]
          )
        end
      end

      def audit_proof(array, index, digest = nil)
        audit_proof_path = Array.new
        element = array[index]

        # This block is inside case with two elements.
        # We have to handle pairs only with our element and add neibour of our element to the path
        # Then we have to update our element
        merkle_tree(array, digest) do |pair_of_elements|
          if pair_of_elements.include?(element)
            audit_proof_path << begin 
              if pair_of_elements.first == element 
                {
                   position: 'right',
                   value: pair_of_elements.last
                }
              else
                {
                  position: 'left',
                  value: pair_of_elements.first
                }
              end
            end
  
            element = node_hash(digest, pair_of_elements.first, pair_of_elements.last)
          end
        end
  
        audit_proof_path
      end

      # Culculate a head of tree using audit_proof path
      def consistency_proof(array, index, digest = nil)
        sub_array = array[0..index]

        audit_proof(sub_array, index, digest).map{ |e| e[:value] }
      end

      # Culculate a head of tree using audit_proof path
      # By this method we can verify is the element a part of the tree or not depends on returned head
      def audit_proof_build_head(audit_proof_path, element, digest = nil) 
        audit_proof_path.inject(element) do |element, node|
          case node[:position]
          when 'right'
            node_hash(digest, element, node[:value])
          when 'left'
            node_hash(digest, node[:value], element)
          end
        end
      end

      # Culculate a head of sub-tree using consistency_proof path
      # By this method we can verify is the tree includes sub-tree
      def consistency_proof_build_head(consistency_proof_path, digest = nil) 
        consistency_proof_path.inject('') do |result, consistency_path_element|
          node_hash(digest, consistency_path_element, result)
        end
      end

      private def node_hash(digest, hash1, hash2)
        summary_hash = hash1 + hash2

        digest ? digest.digest("\x01" + summary_hash) : summary_hash
      end
    end
  end
end