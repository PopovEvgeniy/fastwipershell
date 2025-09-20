unit fastwipershellcode;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLType, UTF8Process, Forms, Controls,
  Graphics, ExtCtrls, StdCtrls;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    StartButton: TButton;
    PassesField: TLabeledEdit;
    DriveField: TLabeledEdit;
    ToolRunner: TProcessUTF8;
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DriveFieldChange(Sender: TObject);
    procedure DriveFieldKeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end;

var MainWindow: TMainWindow;

implementation

procedure wipe_disk(var runner:TProcessUTF8;const passes:string;const disk:string);
begin
 runner.Executable:=ExtractFilePath(Application.ExeName)+'fastwiper.exe';
 runner.Parameters.Clear();
 runner.Parameters.Add(passes);
 runner.Parameters.Add(disk);
 try
  runner.Execute();
 except
  ;
 end;

end;

procedure restrict_input(var key:char);
begin
 if not (LowerCase(key) in ['a'..'z']) then
 begin
  if ord(key)<>VK_BACK then key:=#0;
 end;

end;

procedure window_setup();
begin
 Application.Title:='FAST WIPER SHELL';
 MainWindow.Caption:='FAST WIPER SHELL 0.8.4';
 MainWindow.BorderStyle:=bsDialog;
 MainWindow.Font.Name:=Screen.MenuFont.Name;
 MainWindow.Font.Size:=14;
end;

procedure interface_setup();
begin
 MainWindow.StartButton.Enabled:=False;
 MainWindow.PassesField.NumbersOnly:=True;
 MainWindow.PassesField.MaxLength:=3;
 MainWindow.DriveField.MaxLength:=1;
 MainWindow.PassesField.LabelPosition:=lpLeft;
 MainWindow.DriveField.LabelPosition:=lpLeft;
 MainWindow.PassesField.Text:='';
 MainWindow.DriveField.Text:='';
end;

procedure language_setup();
begin
 MainWindow.StartButton.Caption:='Wipe';
 MainWindow.PassesField.EditLabel.Caption:='Amount of the wipe passes';
 MainWindow.DriveField.EditLabel.Caption:='A drive letter';
end;

procedure setup();
begin
 window_setup();
 interface_setup();
 language_setup();
end;

{$R *.lfm}

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TMainWindow.StartButtonClick(Sender: TObject);
begin
 wipe_disk(MainWindow.ToolRunner,MainWindow.PassesField.Text,MainWindow.DriveField.Text);
end;

procedure TMainWindow.DriveFieldChange(Sender: TObject);
begin
 MainWindow.StartButton.Enabled:=MainWindow.DriveField.Text<>'';
end;

procedure TMainWindow.DriveFieldKeyPress(Sender: TObject; var Key: char);
begin
 restrict_input(key);
end;

end.
