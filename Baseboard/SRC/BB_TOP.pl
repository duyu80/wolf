#!c:/perl64/bin/perl.exe

# declared a variable and set to nothing ""
$cmd = "";

# read from a standard input file (<>)
# perl BB_TOP.pl BB_TOP.pp.v > BB_TOP.v
# perl BB_TOP.pl PRSNT_LED_CTRL.pp.v > PRSNT_LED_CTRL.v
# perl BB_TOP.pl PCIE_RST_CTRL.pp.v > PCIE_RST_CTRL.v
# perl BB_TOP.pl BB_SGPIO.pp.v > BB_SGPIO.v
while (<>) {
  # read each line into a hidden default variable $_
  if (/^;/) {   # find the first ; in any line  (special character ^: first in line, $: last in line)
    s/^;//;     # substitue(replace) initial ^ with nothing
    $cmd .= $_; # concatenate $cmd with the current line
  }
  else {
    s/\"/\\\"/g;
    $cmd .= "printf\(\"$_\"\);";
  }
}
eval $cmd;
