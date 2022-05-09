This repo contains an implementation of "Merkle Hash Trees" (MHT).
In cryptography and computer science, a hash tree or Merkle Hash Tree
is a tree in which every "leaf" (node) is labelled with the cryptographic hash of 
a data block, and every node that is not a leaf (called a branch, inner node, or inode) 
is labelled with the cryptographic hash of the labels of its child nodes.
Specifically, it implements the variant described in
[RFC6962](http://tools.ietf.org/html/rfc6962)


## Basic Usage

Assume that you have such an object, named
`data`, and we'll look at how to use the MHT.

    data = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]

We'll create a new MHT:

    tree = Merkle::HashTree.new(data, Digest::SHA256)

The `Merkle::HashTree` constructor takes exactly two arguments: an object that
implements the data access interface we'll talk about later, and a class (or
object) which implements the same `digest` method signature as the core
`Digest::Base` class.  Typically, this will simply be a `Digest` subclass,
such as `Digest::MD5`, `Digest::SHA1`, or (as in the example above)
`Digest::SHA256`.  This second argument is the way that the MHT calculates
hashes in the tree -- it simply calls the `#digest` method on whatever you
pass in as the second argument, passing in a string and expecting raw octets
out the other end.

Once we have our MHT object, we can start to do things with it.
For example, we can get the hash of the "head" of the tree:


    tree.head   # => "<some long string of octets>"


We can also ask for a "consistency proof", we need to specify an index(n) of the last
element of sub_tree (as a result it'll be (0...n)):


    consistency_proof = tree.consistency_proof_build(10)   # => ["<hash>", "<hash>", ... ]

    
 You can test it checking sum with hash head of the tree. Or use:


    tree.consistency_proof_build_head(consistency_proof)   # => "<some long string of octets>"


There are also such things as "audit proofs" (again, I'm not going to
explain them here), which you get by specifying a single leaf number and a
subtree ID:


    audit_proof = tree.audit_proof_build(10)   # => [ { value: "<hash>", position: "left" }, { value: "<hash>", position: "right" }, ... ]


In this example, the audit proof will return a list of hashes
that demonstrate that leaf 13 is in the tree and hasn't been removed or altered.
You can test it checking sum with hash head of the tree. Or use:


    tree.audit_proof_build_head(audit_proof, data[10])   # => "<some long string of octets>"
  
  


