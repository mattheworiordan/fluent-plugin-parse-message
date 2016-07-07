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
          puts "About to parse: '#{record["message"]}'"
          @parser.parse(record["message"]) do |t, r|
            puts "Parsed time #{t} - #{r.nil?} - #{r}"
            if t
              time = t
            end
            puts "Record #{record}"
            record.merge!(r) if r
            puts "Record merged"
          end

          new_es.add(time, record)
          puts "Add time & record"
        rescue => e
          puts "Emitted error #{e} for '#{record["message"]}'"
          router.emit_error_event(tag, time, record, e)
        end
      end
      new_es
    end
  end
end
