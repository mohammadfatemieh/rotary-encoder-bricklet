program ExampleCallback;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletRotaryEncoder;

type
  TExample = class
  private
    ipcon: TIPConnection;
    re: TBrickletRotaryEncoder;
  public
    procedure CountCB(sender: TBrickletRotaryEncoder; const count: integer);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback function for count callback }
procedure TExample.CountCB(sender: TBrickletRotaryEncoder; const count: integer);
begin
  WriteLn(Format('Count: %d', [count]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  re := TBrickletRotaryEncoder.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Set Period for count callback to 0.05s (50ms)
    Note: The count callback is only called every 50ms if the
          count has changed since the last call! }
  re.SetCountCallbackPeriod(50);

  { Register count callback to procedure CountCB }
  re.OnCount := {$ifdef FPC}@{$endif}CountCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
