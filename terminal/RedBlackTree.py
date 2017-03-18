class Tree:
    def __init__(self):
        tree.root = Node()

    def insert(self, value):


    def insert_helper(self, value, node):
        if node.left == None and value <= node.value:
            node.left = Node(value)
        if node.right == None and value > node.value:
            node.right = Node(value)
        

    def delete(self, value):

class Node:

    def __init__(self, value, left = None, right = None):
        self.value = value
        self.left = left
        self.right = right