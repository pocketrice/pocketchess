% "Buffered cell array"
classdef Buffer < handle
    properties (Constant)
        DEF_BUFFER_SIZE = 24;
    end

    properties
        Pool
        Size
        Len
        FFlag
    end

    methods
        function obj = Buffer(size)
            if nargin >= 1
                obj.Pool = cell(1, size);
            else
                obj.Pool = cell(1, Buffer.DEF_BUFFER_SIZE);
            end
            obj.Size = length(obj.Pool);
            obj.Len = 0;
            obj.FFlag = 0;
        end

        % "Expand buffer if needed"
        % If at max length, exponentially increase buffer (x2).
        % Call this prior to adding any items.
        function cbin(obj)
            if obj.FFlag
                error("Buffer flushed and cannot be used.");
            end

            if obj.Len >= obj.Size
                obj.Pool = [ obj.Pool, cell(1, obj.Size) ];
                obj.Size = obj.Size * 2;
              %  fprintf("Buffer changed size from %i to %i — consider new defsize.\n", obj.BufferSize / 2, obj.BufferSize);
            end
        end

        % "Add item"
        function a(obj, item)
             if obj.FFlag
                error("Buffer flushed and cannot be used.");
             end

            obj.cbin();

            obj.Pool{obj.Len + 1} = unwrap(item, 1);
            obj.Len = obj.Len + 1;
        end

        % "Add all items"
        function aa(obj, items)
             if obj.FFlag
                error("Buffer flushed and cannot be used.");
             end

            for item = items
                obj.a(item);
            end
        end

        % "Flush buffer"
        % The buffer shouldn't be used after flushing.
        % For regular array, simply cell2mat the result.
        function cellarr = flush(obj)
            if obj.FFlag
                error("Buffer flushed and cannot be used.");
            end
            
            cellarr = obj.Pool(1:obj.Len);

            obj.Pool = {};
            obj.Size = -1;
            obj.Len = -1;
            obj.FFlag = 1;
        end
    end
end
