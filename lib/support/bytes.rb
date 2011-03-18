module Lolita
  module Support
    # Convert bytes to closest possible unit.
    # ====Example
    #     byte_converter=Lolita::FileUpload::Bytes.new(1024)
    #     byte_converter.unit #=> kilobytes
    #     byte_convertes.value #=> 1.0
    class Bytes
      
      @@default_unit="byte"
      @@units=%w(kilobyte megabyte gigabyte)

      def initialize(bytes)
        @power=0
        @bytes=bytes
      end

      # Return bytes
      def bytes
        @bytes
      end

      # Return unit name
      def unit
        @unit||=set_unit
      end

      # Return unit value
      def value
        @value||=set_value
      end

      private

      def set_unit
        count=self.value
        system_name=([@@default_unit]+@@units)[@power]
        I18n.t("lolita.support.bytes.#{system_name}",:count=>count)
      end

      def set_value
        @@units.size.downto(1) do |pow|
          if self.bytes>=1024**pow
            @power=pow 
            break
          end
        end
        (self.bytes.to_f/(1024**@power).to_f).round(2)
      end

    end
  end
end