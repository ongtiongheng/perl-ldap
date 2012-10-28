#!perl

BEGIN {
  require "t/common.pl";
  start_server();
}

print "1..3\n";

$ldap = client();
ok($ldap, 'client with IPv4/IPv6 auto-selection' .
   ($ldap ? (', bound to ' . $ldap->{net_ldap_socket}->peerhost) : ''));

$ldap = client(inet4 => 1);
ok($ldap, 'client with IPv4' .
   ($ldap ? (', bound to ' . $ldap->{net_ldap_socket}->peerhost) : ''));


SKIP: {
  skip('IO::Socket::INET6 not installed', 1)
    unless (eval { require IO::Socket::INET6; });

  $ldap = client(inet6 => 1);
  ok($ldap, 'client with IPv6' .
     ($ldap ? (', bound to ' . $ldap->{net_ldap_socket}->peerhost) : ''));
}
