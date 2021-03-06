#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;
use Test::Differences;

use App::LexicalVarReplace;

my $code = <<'END_CODE';
use MooseX::Declare;

class Test {
    has a_var => ( is => 'rw', isa => 'Str' );
    has b_var => ( is => 'rw', isa => 'Str' );

    method some_method {
        my $x_var = 1;

        print "Do stuff with ${x_var}\n";
        $x_var += 1;

        my %hash;
        for my $i (1..5) {
            $hash{$i} = $x_var;
        }
    }
}
END_CODE

my $shiny_replacement = <<'SHINY_REPLACEMENT';
use MooseX::Declare;

class Test {
    has a_var => ( is => 'rw', isa => 'Str' );
    has b_var => ( is => 'rw', isa => 'Str' );

    method some_method {
        my $shiny = 1;

        print "Do stuff with ${shiny}\n";
        $shiny += 1;

        my %hash;
        for my $i (1..5) {
            $hash{$i} = $shiny;
        }
    }
}
SHINY_REPLACEMENT

eq_or_diff(
    App::LexicalVarReplace->new( code => $code )
      ->replace_var( line => 11, column => 9, replacement => 'shiny', ),
    $shiny_replacement,
    'replace scalar'
);

my $stuff_replacement = <<'STUFF_REPLACEMENT';
use MooseX::Declare;

class Test {
    has a_var => ( is => 'rw', isa => 'Str' );
    has b_var => ( is => 'rw', isa => 'Str' );

    method some_method {
        my $x_var = 1;

        print "Do stuff with ${x_var}\n";
        $x_var += 1;

        my %stuff;
        for my $i (1..5) {
            $stuff{$i} = $x_var;
        }
    }
}
STUFF_REPLACEMENT

eq_or_diff(
    App::LexicalVarReplace->new( code => $code )
      ->replace_var( line => 15, column => 13, replacement => 'stuff', ),
    $stuff_replacement,
    'replace hash'
);

