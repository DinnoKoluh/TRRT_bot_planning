function [G1, Ga, Gb, con, i] = myRoboBiRRT(robot, G1, G2, q_init, q_final, plotGraph, eta, mi)   
    maxIter = G1.maxNodeNum + G2.maxNodeNum;
    G1.addNode(q_init);
    G2.addNode(q_final);
    con = [q_init; q_final];
    q_last1 = q_init;
    Ga = 0;
    Gb = 0;   

    if plotGraph
        plotMarker(q_init.coordinates, 'S');
        plotMarker(q_final.coordinates, 'F');
    end
        
    i = 0; % 
    k1 = 2; % Brojac cvorova za G1
    k2 = 2; % Brojac cvorova za G2
    q_new2 = q_final;    
    
    a = tic;
    
    while i <= maxIter/2
        i = i + 1;
        
        if rand() < eta || i == 1
            if rand() < mi(1,1) && i > 2
                q_rand1 = Node(q_new2.coordinates, k1);
                %q_rand1 = Node(G2.getMean(), k1);
            else
                q_rand1 = Node(G1.randConfig(), k1);
            end
            [q_near1, q_near_dis1] = G1.nearestNode(q_rand1);

            if q_near_dis1 > G1.deltaQ
                q_new1 = G1.newConfig(q_near1, q_rand1);
            else
                q_new1 = q_rand1;
            end
            
            
            if isa(G1, 'TRRT')
                condition = G1.transitionTest(q_near1, q_new1) && G1.minExpandControl(q_near1, q_rand1);
                %condition = condition && G1.transitionTest(q_near1, q_new1)
            else
                robot.currConfig = toRad(q_new1.coordinates');
                condition = ~checkRoboIntersection(robot);
            end

            % provjera da li je tacka van prepreke
            if condition
%                 b = toc(a);
%                 plot(k1,b,'bx');
%                 hold on;
                q_last1 = q_new1;
                G1.addNode(q_new1); % dodavanje novog cvora grafu
                G1.addEdge(q_near1, q_new1); % dodavanje nove grane grafu

                % plotanje
                if plotGraph
                    plotEdge(q_near1, q_new1, 'r',1.5);
                    plotNode(q_new1, 'b.', 8);
                    drawnow;
                    %text(q_new.coordinates(1,1),q_new.coordinates(1,2),[num2str(q_new.index)],'FontSize',9)
                end
              k1 = k1 + 1;
            else
                continue;
            end
            
        else
%             if k2 > 100
%                 eta = 0.5;
%                 mi = [0.5, 0.5];
%             end
            
            if rand() < mi(1,2)
                q_rand2 = Node(q_new1.coordinates, k2);
                %q_rand2 = Node(G1.getMean(), k2);
            else
                q_rand2 = Node(G2.randConfig(), k2);
            end
            
            [q_near2, q_near_dis2] = G2.nearestNode(q_rand2);

            if q_near_dis2 > G2.deltaQ
                q_new2 = G2.newConfig(q_near2, q_rand2);
            else
                q_new2 = q_rand2;
            end
           
            
            if isa(G2, 'TRRT')
                condition = G2.transitionTest(q_near2, q_new2) && G2.minExpandControl(q_near2, q_rand2);
            else
                robot.currConfig = toRad(q_new2.coordinates');
                condition = ~checkRoboIntersection(robot);
            end
            % provjera da li je tacka van prepreke
            if condition

                G2.addNode(q_new2); % dodavanje novog cvora grafu
                G2.addEdge(q_near2, q_new2); % dodavanje nove grane grafu

                % plotanje
                if plotGraph
                    plotEdge(q_near2, q_new2, 'k',1.5);
                    plotNode(q_new2, 'g.', 8);
                    drawnow;
                    %text(q_new.coordinates(1,1),q_new.coordinates(1,2),[num2str(q_new.index)],'FontSize',9)
                end
              k2 = k2 + 1;
            else
                continue;
            end
        end
        
        % Pokusaj povezivanja
        q_try = G2.nearestNode(q_last1);
        % Direktno spajanje ako nema prepreka
        if (distance(q_last1.coordinates, q_try.coordinates) < 10 && ~checkRoboMove(robot, toRad(q_last1.coordinates)', toRad(q_try.coordinates)', 15)) 
            Ga = copy(G1);
            Gb = copy(G2);
            G1.mergeRRTs(G2, q_last1, q_try);
            con = [q_last1; q_try];
            display(['Pronadjeno rjesenje! (Dvosmjerni myBi', class(G1), ').', sprintf('\n'), 'Broj potrebnih iteracija: ', ...
                num2str(i),sprintf('\n'), 'Broj cvorova grafa: ', num2str(G1.getNodeNum), sprintf('\n'), 'Odnos grafova: ', num2str(1-G2.getNodeNum/G1.getNodeNum),'.']);
            return;
        end

    end
    display('Nije pronadjeno rjesenje za uneseni cilj!');

end






