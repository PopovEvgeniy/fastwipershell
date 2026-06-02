unit fastwipershellcode;

{
 This sofware was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses Classes, SysUtils, LCLType, UTF8Process, Forms, Controls, Graphics,
  ExtCtrls, StdCtrls, Menus;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    EmptyMenu: TPopupMenu;
    StartButton: TButton;
    PassesField: TLabeledEdit;
    DriveField: TLabeledEdit;
    ToolRunner: TProcessUTF8;
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DriveFieldChange(Sender: TObject);
  private
    procedure window_setup();
    procedure interface_setup();
    procedure language_setup();
    procedure setup();
  public
    { public declarations }
  end;

var MainWindow: TMainWindow;

implementation

procedure TMainWindow.window_setup();
begin
 Application.Title:='FAST WIPER SHELL';
 Self.Caption:='FAST WIPER SHELL 0.8.8';
 Self.BorderStyle:=bsDialog;
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.interface_setup();
begin
 Self.StartButton.Enabled:=False;
 Self.PassesField.NumbersOnly:=True;
 Self.PassesField.MaxLength:=3;
 Self.DriveField.MaxLength:=1;
 Self.PassesField.LabelPosition:=lpLeft;
 Self.DriveField.LabelPosition:=lpLeft;
 Self.PassesField.Text:='';
 Self.DriveField.Text:='';
 Self.PassesField.PopupMenu:=Self.EmptyMenu;
 Self.DriveField.PopupMenu:=Self.EmptyMenu;
end;

procedure TMainWindow.language_setup();
begin
 Self.StartButton.Caption:='Wipe';
 Self.PassesField.EditLabel.Caption:='Amount of the wipe passes';
 Self.DriveField.EditLabel.Caption:='A drive letter';
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
 Self.interface_setup();
 Self.language_setup();
end;

procedure wipe_disk(var runner:TProcessUTF8;const passes:string;const disk:string);
begin
 runner.Executable:=ExtractFilePath(Application.ExeName)+'fastwiper.exe';
 runner.Parameters.Clear();
 runner.Parameters.Add(disk);
 runner.Parameters.Add(passes);
 try
  runner.Execute();
 except
  ;
 end;

end;

{$R *.lfm}

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
end;

procedure TMainWindow.StartButtonClick(Sender: TObject);
begin
 wipe_disk(Self.ToolRunner,Self.PassesField.Text,Self.DriveField.Text);
end;

procedure TMainWindow.DriveFieldChange(Sender: TObject);
begin
 Self.StartButton.Enabled:=Self.DriveField.Text<>'';
end;

end.
