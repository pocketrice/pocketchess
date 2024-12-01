% "Buffered cell array"
classdef Buffer < handle
    properties (Constant)
        DEF_BUFFER_SIZE = 24;
    end

    properties
        BufferPool
        BufferSize
        BufferLen
        FlushFlag
    end

    methods
        function obj = Buffer(size)
            if nargin >= 1
                obj.BufferPool = cell(1, size);
            else
                obj.BufferPool = cell(1, Buffer.DEF_BUFFER_SIZE);
            end
            obj.BufferSize = length(obj.BufferPool);
            obj.BufferLen = 0;
            obj.FlushFlag = 0;
        end

        % "Expand buffer if needed"
        % If at max length, exponentially increase buffer (x2).
        % Call this prior to adding any items.
        function cbin(obj)
            if obj.FlushFlag
                error("Buffer flushed and cannot be used.");
            end

            if obj.BufferLen >= obj.BufferSize
                obj.BufferPool = [ obj.BufferPool, cell(1, obj.BufferSize) ];
                obj.BufferSize = obj.BufferSize * 2;
              %  fprintf("Buffer changed size from %i to %i — consider new defsize.\n", obj.BufferSize / 2, obj.BufferSize);
            end
        end

        % "Add item"
        function a(obj, item)
             if obj.FlushFlag
                error("Buffer flushed and cannot be used.");
             end

            obj.cbin();

            obj.BufferPool{obj.BufferLen + 1} = unwrap(item, 1);
            obj.BufferLen = obj.BufferLen + 1;
        end

        % "Add all items"
        function aa(obj, items)
             if obj.FlushFlag
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
            if obj.FlushFlag
                error("Buffer flushed and cannot be used.");
            end
            
            cellarr = obj.BufferPool(1:obj.BufferLen);

            obj.BufferPool = {};
            obj.BufferSize = -1;
            obj.BufferLen = -1;
            obj.FlushFlag = 1;
        end
    end
end
