package Utils::Util;

use strict;
use warnings;

use JSON;

sub read_conf{
    open my $fh, '<', '/perl_training/config.json';

    my $file_content = '';

    while (my $line = <$fh>){
        $file_content .= $line;
    }

    my $file_content_as_hash = JSON::from_json($file_content);

    return $file_content_as_hash;
}

1;
