require "portus/ldap"
Warden::Strategies.add(:ldap_authenticatable, Portus::LDAP)
