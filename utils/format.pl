#!/usr/bin/perl

use strict;
use warnings;
use utf8;

for my $filename (@ARGV) {
    process($filename);
}

sub process {
    my $filename = shift;
    
    open my $fh, "<:encoding(cp1251)", $filename or die;
    #Skip header
    <$fh>;

    my $accum_string = "";

    while (my $line = <$fh>) {
        $line =~ s/[\r\n]+//g;
        my ($def, $start, $end, $capacity, $name, $geo) = split(/;/, $line);
        $name =~ s/\"//g;
        my $ts_name = ts($name);
        
        $start = sprintf("%07d", $start);
        $end = sprintf("%07d", $end);
        $accum_string .= "7${def}${start};7${def}${end};${name};${ts_name};\n";
    }
    close $fh;

    open $fh, ">:encoding(UTF-8)", $filename or die;
    print $fh $accum_string;
    close $fh;
}

sub ts {
	my $textline = shift;
	$textline =~ s/А/A/g;		$textline =~ s/а/a/g;
	$textline =~ s/Б/B/g;		$textline =~ s/б/b/g;
	$textline =~ s/В/V/g;		$textline =~ s/в/v/g;
	$textline =~ s/Г/G/g;		$textline =~ s/г/g/g;
	$textline =~ s/Д/D/g;		$textline =~ s/д/d/g;
	$textline =~ s/Е/E/g;		$textline =~ s/е/e/g;
	$textline =~ s/Ё/E/g;		$textline =~ s/ё/e/g;
	$textline =~ s/Ж/Zh/g;		$textline =~ s/ж/zh/g;
	$textline =~ s/З/Z/g;		$textline =~ s/з/z/g;
	$textline =~ s/И/I/g;		$textline =~ s/и/i/g;
	$textline =~ s/Й/I/g;		$textline =~ s/й/i/g;
	$textline =~ s/К/K/g;		$textline =~ s/к/k/g;
	$textline =~ s/Л/L/g;		$textline =~ s/л/l/g;
	$textline =~ s/М/M/g;		$textline =~ s/м/m/g;
	$textline =~ s/Н/N/g;		$textline =~ s/н/n/g;
	$textline =~ s/О/O/g;		$textline =~ s/о/o/g;
	$textline =~ s/П/P/g;		$textline =~ s/п/p/g;
	$textline =~ s/Р/R/g;		$textline =~ s/р/r/g;
	$textline =~ s/ТС/T-S/g;	$textline =~ s/Тс/T-s/g;	$textline =~ s/тс/t-s/g;
	$textline =~ s/С/S/g;		$textline =~ s/с/s/g;
	$textline =~ s/Т/T/g;		$textline =~ s/т/t/g;
	$textline =~ s/У/U/g;		$textline =~ s/у/u/g;
	$textline =~ s/Ф/F/g;		$textline =~ s/ф/f/g;
	$textline =~ s/Х/Kh/g;		$textline =~ s/х/kh/g;
	$textline =~ s/Ц/Ts/g;		$textline =~ s/ц/ts/g;
	$textline =~ s/Ч/Ch/g;		$textline =~ s/ч/ch/g;
	$textline =~ s/Ш/Sh/g;		$textline =~ s/ш/sh/g;
	$textline =~ s/Щ/Shch/g;	$textline =~ s/щ/shch/g;
	$textline =~ s/Ь//g;		$textline =~ s/ь//g;
	$textline =~ s/Ы/Y/g;		$textline =~ s/ы/y/g;
	$textline =~ s/Ъ//g;		$textline =~ s/ъ//g;
	$textline =~ s/Э/E/g;		$textline =~ s/э/e/g;
	$textline =~ s/Ю/Yu/g;		$textline =~ s/ю/yu/g;
	$textline =~ s/Я/Ya/g;		$textline =~ s/я/ya/g;
	return $textline;
}