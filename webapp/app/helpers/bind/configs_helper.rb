module Bind::ConfigsHelper

	def timestamp(timestamp)
		return "cat > timestamp << EOS\n#{timestamp}\nEOS\n"
	end


	def zones_conf(domains)
		zones = "cat > zones.conf-temp << EOS\n"
		for domain in domains	
			zones << "zone \"#{domain.name}\" {\n"
			zones << "  file \"#{domain.name}\";\n"

			if domain.native?
				zones << "  type master;\n"
			else
				zones << "  type slave;\n"
				zones << "  masters {\n"
				zones << "    #{domain.master};\n"
				zones << "  };\n"
			end

			if domain.allow_queries.count > 0
				zones << "  allow-query {\n"
				for query in domain.allow_queries
					zones << "    #{query.clients};\n"
				end
				zones << "  };\n"
			end

			zones << "};\n\n"
		end
		zones << "EOS\n"

		return zones
	end


	def zone_files(domains)
		files = ""
		for domain in domains
			files << zone_file(domain)
		end

		return files
	end


	private


	def zone_file(domain)
		if domain.slave?
			return ""
		end

		content = ""
		for record in domain.records
			if record.soa?
				content = prepend_soa(content, record)
			else
				content = append_record(content, record)
			end
		end
		return "cat > zones-temp/#{domain.name} << EOS\n#{content}\nEOS\n"
	end


	def prepend_soa(content, record)
		lines = "\\$TTL #{record.ttl}\n\\$ORIGIN #{record.domain.name}\n"
		lines << "#{record.fqdn_name}\t\t#{record.recclass}\t#{record.type}\t#{record.pref}\t#{record.content}\n"
		return lines + content
	end


	def append_record(content, record)
		return content << "#{record.name}\t#{record.ttl}\t#{record.recclass}\t#{record.type}\t#{record.pref}\t#{record.content}\n"
	end

end
