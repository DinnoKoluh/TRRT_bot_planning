function [G, q_end] = findRRTstar(G, q_init, q_final, plotGraph, option)    
    % Option for the continuation of the graph expansion
    if G.getNodeNum() == 0
        G.addNode(q_init); % adding the starting node
    end
    
    if plotGraph
        plotMarker(q_init.coordinates, 'S');
        plotMarker(q_final.coordinates, 'F');
    end
    
    q_end = Node(); % creation of the final node
    
    i = G.getNodeNum()+1; % Because we already added one node in the graph
    
    % FOR BRRT PUT continueToMaxNodes = 1
    continueToMaxNodes = 0; % Are we going to the max number of nodes or not
    if strcmp(option, 'BiRRT')
        continueToMaxNodes = 1;
    end
    foundSolution = 0; % Bool variable which stores if we found a solution
    
    while i <= G.maxNodeNum
        % choosing a random configuration
        q_rand = Node(G.randConfig(), i);
        
        % finding the closest configuration to the random configuration
        [q_near, q_near_dis] = G.nearestNode(q_rand);
        
        %if the distance q_near-q_rand greater than deltaQ search for a new
        %node, if not then q_near becomes the new node
        if q_near_dis > G.deltaQ
            % searching for a new configuration
            q_new = G.newConfig(q_near, q_rand);
        else
            q_new = q_rand;
        end

        condition = isempty(G.obstacles) || checkIntersection(G.obstacles, q_new.coordinates, q_near.coordinates, 10);
        if isa(G, 'TRRT')
            condition = condition && G.transitionTest(q_near, q_new) && G.minExpandControl(q_near, q_rand);
        end
        % checks if the point is outside the obstacle
        if condition
            r = G.getBallRadius(i, length(q_new.coordinates));
            parents = G.getNodesInBall(r, q_new.coordinates);
            G.addNode(q_new); % adding a new node to the graph
            if isempty(parents)
                bestParent = q_near;
            else
                [bestParent, parents] = G.getBestParent(parents, q_new);
            end
            G.addEdge(bestParent, q_new); %adding a new edge to the graph
            G.rewire(q_new, parents); 
            % plotting
            if plotGraph
                plotEdge(bestParent, q_new, 'r',1.5);
                plotNode(q_new, 'b.', 8);
                drawnow;
                %text(q_new.coordinates(1,1),q_new.coordinates(1,2),[num2str(q_new.index)],'FontSize',9)
            end
            
            % When the solution is found and we choose to go to the max
            % number of nodes then we must stop by assigning a value to
            % q_end
            if foundSolution == 0
                q_end =  q_new;
            end
            
            if distance(q_new.coordinates, q_final.coordinates) <= G.minDistance 
                foundSolution = 1;
                % If we choose not to go the the max number of nodes then
                % we stop at the node which is a the minimum distance from
                % the final coordinates
                if continueToMaxNodes == 0
                    display(['Solution found(', option, '). Number of the final node: ', num2str(q_new.index), '!']);
                    return;
                end
            elseif (distance(q_new.coordinates, q_final.coordinates) <= G.minDistance) && continueToMaxNodes == 1
                q_end = q_new;
                continueToMaxNodes = 2;
            end
            %i

        else
            continue;
        end
        i = i + 1;
    end

    if foundSolution == 0 && continueToMaxNodes == 0
        display('Solution not found for the given goal!');
    end
end

