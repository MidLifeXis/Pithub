package    # hide from PAUSE
  Pithub::Test::UA;

use Moose;
use File::Basename qw(dirname);
use File::Slurp qw(read_file);
use HTTP::Response;
use Test::More;
use namespace::autoclean;

sub request {
    my ( $self, $request ) = @_;
    my $path = sprintf '%s/http_response/%s/%s.%s', dirname(__FILE__), $request->uri->host, $request->uri->path, $request->method;
    my %query_form = $request->uri->query_form;
    while ( my ( $k, $v ) = each %query_form ) {
        $path .= sprintf '.%s-%s', $k, $v;
    }
    if ( -f $path ) {
        my $res = read_file($path);
        return HTTP::Response->parse($res);
    }
    return HTTP::Response->new;
}

__PACKAGE__->meta->make_immutable;

1;
