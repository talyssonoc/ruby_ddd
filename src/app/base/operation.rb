module App
  module Base
    class Operation
      class << self
        attr_accessor :result_class

        private

        def outputs(*output_names)
          @result_class = Result.for_outputs(*output_names)
        end
      end

      def call(*args)
        perform(*args)

        yield @result
      end

      def output(output_name, output_value)
        @result = self.class.result_class.new(output_name, output_value)
      end

      class Result
        def self.for_outputs(*output_names)
          Class.new(Result) do
            output_names.each(&method(:define_output_method))
          end
        end

        def self.define_output_method(output_name)
          define_method(output_name) do |&block|
            block.call(@output_value) if @output_name == output_name
          end
        end

        def initialize(output_name, output_value)
          @output_name = output_name
          @output_value = output_value
        end
      end
    end
  end
end
