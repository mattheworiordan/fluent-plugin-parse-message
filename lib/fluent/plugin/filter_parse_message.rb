module Fluent
  class ParseMessageFilter < Filter
    Fluent::Plugin.register_filter("parse_message", self)

    config_param :format,      :string
    config_param :time_format, :string, default: nil

    def configure(conf)
      super

      @parser = Fluent::Plugin.new_parser(conf["format"])
      @parser.configure(conf)
    end

    def filter_stream(tag, es)
      new_es = MultiEventStream.new
      es.each do |time, record|
        begin
          @parser.parse(record["message"]) do |t, r|
            if t
              time = t
            end
            record.merge!(r)
          end

          new_es.add(time, record)
        rescue => e
          router.emit_error_event(tag, time, record, e)
        end
      end
      new_es
    end
  end
end
