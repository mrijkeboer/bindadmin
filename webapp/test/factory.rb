require File.dirname(__FILE__) + '/factory/allow_query_factory'
require File.dirname(__FILE__) + '/factory/default_factory'
require File.dirname(__FILE__) + '/factory/domain_factory'
require File.dirname(__FILE__) + '/factory/mail_server_factory'
require File.dirname(__FILE__) + '/factory/name_server_factory'
require File.dirname(__FILE__) + '/factory/record_factory'
require File.dirname(__FILE__) + '/factory/server_factory'
require File.dirname(__FILE__) + '/factory/user_factory'

module Factory

	include AllowQueryFactory
	include DefaultFactory
	include DomainFactory
	include MailServerFactory
	include NameServerFactory
	include RecordFactory
	include ServerFactory
	include UserFactory

end
