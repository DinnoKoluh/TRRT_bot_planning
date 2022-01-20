clear;
G = RRTgraph(10);
N1 = Node();
N2 = Node([1,1], 5);
N3 = Node([5,6], 10);
N4 = Node([2,5], 8);
N1.setCoordinates([2,1]);
N1.setIndex(2);

G.addNode(N1);
G.addNode(N2);
G.addNode(N3);
G.addNode(N4);

G.addEdge(N1, N2);
G.addEdge(N2, N4);
G.addEdge(N3, N1);
G.addEdge(N4, N1);

G.getNodeIndexes;

G.getEdgeMatrix
for i = 1:4
    G.edges(i,1).setNode1(N4);
    G.edges(i,1).setNode2(N3);
end
G.getEdgeMatrix
% myEdges(1,1) = Edge(N1,N2);
% myEdges(2,1) = Edge(N2, N4);
% myEdges(3,1) = Edge(N3, N2);
% myEdges(4,1) = Edge(N4, N3);

% for i = 1:4
% %     myEdges(i,1).setNode2Index(55);
%     myEdges(i,1).setNode1(N1);
% end
% myEdges(1,1).setNode2Index(77);
% myEdges(2,1).setNode2Index(77);
% myEdges(3,1).setNode2Index(77);
% myEdges(4,1).setNode2Index(77);
% for i = 1:4
%     [myEdges(i,1).node1.index; myEdges(i,1).node2.index]
% end
% G.getEdgeMatrix;

% b = [G.edges.node1]
% [b(:).index]

