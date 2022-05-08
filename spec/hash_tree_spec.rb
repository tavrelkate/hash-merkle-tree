require 'spec_helper'

describe Merkle::HashTree do
  context 'WITHOUT hashing' do 
    subject { described_class.new(data) }

    let(:data)    { %w[a b c d e f g h i j k l m n o p q r s t u v w x y z] }
    let(:head)    { 'abcdefghijklmnopqrstuvwxyz' }
    let(:index)   { 3 }
    let(:element) { data[index] }

    let(:audit_proof) do
      [
        {:position=>"left",  :value=>"c" },
        {:position=>"left",  :value=>"ab"},
        {:position=>"right", :value=>"ef"},
        {:position=>"right", :value=>"gh"},
        {:position=>"right", :value=>"ij"},
        {:position=>"right", :value=>"kl"},
        {:position=>"right", :value=>"mn"},
        {:position=>"right", :value=>"op"},
        {:position=>"right", :value=>"qr"},
        {:position=>"right", :value=>"st"},
        {:position=>"right", :value=>"uv"},
        {:position=>"right", :value=>"wx"},
        {:position=>"right", :value=>"yz"}
      ]
    end

    let(:consistency_proof) do
      [ "c", "ab"]
    end

    it "Returns valid head" do
      expect(subject.head_build).to eql(head)
    end
    
    it "Returns valid audit proof" do
      expect(subject.audit_proof_build(index)).to eql(audit_proof)
    end
    
    it "Returns valid consistency proof" do
      expect(subject.consistency_proof_build(index))
        .to eql(consistency_proof)
    end

    it "Returns valid audit proof head" do
      expect(subject.head_build)
        .to eql(subject.audit_proof_build_head(audit_proof, element))
    end

    it "Returns valid consistency proof head" do
      expect(described_class.new(data[0...index]).head_build)
        .to eql(subject.consistency_proof_build_head(consistency_proof))
    end
  end

  context 'WITH hashing' do 
    subject { Merkle::HashTree.new(data, Digest::SHA256) }

    # TODO: Add examples
  end
end

