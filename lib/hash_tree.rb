# frozen_string_literal: true

require_relative 'algorithm'
require 'digest'

module Merkle
  class HashTree
    ALGORITHM_CLASS = Merkle::Algorithm

    def initialize(incoming_data, digest = nil)
      @algorithm     = ALGORITHM_CLASS
      @digest        = digest
      @incoming_data = incoming_data
      @hashed_data   = incoming_data_to_hashes
    end

    attr_reader :hashed_data, :incoming_data, :digest, :algorithm, :head, :audit_proof,
                :consistency_proof, :consistency_proof_head, :audit_proof_head

    def head_build
      @head =
        algorithm.merkle_tree(hashed_data, digest)
    end

    def audit_proof_build(index)
      @audit_proof =
        algorithm.audit_proof(hashed_data, index, digest)
    end

    def audit_proof_build_head(audit_proof_path, element)
      @audit_proof_head =
        algorithm.audit_proof_build_head(audit_proof_path, element, digest)
    end

    def consistency_proof_build(index)
      @consistency_proof =
        algorithm.consistency_proof(hashed_data, index, digest)
    end

    def consistency_proof_build_head(consistency_proof_path)
      @consistency_proof_head =
        algorithm.consistency_proof_build_head(consistency_proof_path, digest)
    end

    private def incoming_data_to_hashes
      digest ? incoming_data.map! { |el| digest.digest("\u0001#{el}") } : incoming_data
    end
  end
end
