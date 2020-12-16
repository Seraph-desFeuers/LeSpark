=begin
USAGE: 
  pass the source to the program to make it works:
    cat my_code.cpp | perl embedded_perl.pl > my_code_generated.cpp

SYNTAX:
To embed perl code just make a multi line comment like this:
  int main ( ) {
  /*-| Perl |-
    for my $x (A..Z) {
      print "  printf(\"$x\")\n";
    }
  */
  return 0;
}
  This example should generate this code:
  int main ( ) {
    printf("A")
    printf("B")
    printf("C")
    printf("D")
    printf("E")
    printf("F")
    printf("G")
    printf("H")
    printf("I")
    printf("J")
    printf("K")
    printf("L")
    printf("M")
    printf("N")
    printf("O")
    printf("P")
    printf("Q")
    printf("R")
    printf("S")
    printf("T")
    printf("U")
    printf("V")
    printf("W")
    printf("X")
    printf("Y")
    printf("Z")
    
    return 0;
  }
=cut

sub clear_eval {
    my $str = shift;
    my $out = "";
    open my $fh, '>', \$out or die $!;
    select $fh;
    eval $str;
    select STDOUT;
    return $out;
}


my @file = <STDIN>;
my $conc = join "", @file;
print $conc =~ s/\/\*-\| Perl \|-(.*)\*\//clear_eval($1)/rgse;
