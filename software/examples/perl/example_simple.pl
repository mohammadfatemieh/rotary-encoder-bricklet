#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletRotaryEncoder;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Rotary Encoder Bricklet

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $re = Tinkerforge::BrickletRotaryEncoder->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current count without reset
my $count = $re->get_count(0);
print "Count: $count\n";

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
