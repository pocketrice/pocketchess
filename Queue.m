classdef Queue < handle
    properties (Constant = true)
        INITIAL_SIZE = 10; % Initial size of (resizable) list; this is for efficiency
    end

    properties
        Data, % Must be {} vector
        Empty, % Must be <T>
        Length % Must be uint32
    end
    
    methods
        function obj = Queue(Type)
            obj.Data = repmat({Type}, 1, Queue.INITIAL_SIZE);
            obj.Empty = {Type};
            obj.Length = 0;
        end

        % Enqueue 1 item (must be single)
        function enq(obj, item)
            obj.Length = obj.Length + 1;
            obj.Data = horzcat({item}, obj.Data);
        end

        % Enqueue several items (must be vector)
        function enqa(obj, items)
            for item = items
                if (iscell(item))
                    obj.enq(item{1});
                else
                    obj.enq(item);
                end
            end
        end

        % Dequeue 1 item
        function [item] = deq(obj)
            cell = obj.Data(obj.Length);
            item = cell(1);

            obj.Data(obj.Length) = obj.Empty;
            obj.Length = obj.Length - 1;
        end

        % Report if empty
        function result = isEmpty(obj)
            result = (obj.Length == 0);
        end

        % Clear queue
        function clear(obj)
            obj.Data = repmat(obj.Empty, 1, Queue.INITIAL_SIZE);
            obj.Length = 0;
        end

        % Convert to vector (empty space trimmed).
        function data = vec(obj)
            data = obj.Data(1:obj.Length);
        end
    end
end