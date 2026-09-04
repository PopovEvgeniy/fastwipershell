unit fastwipershellcode;

{
 This sofware was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses Classes, SysUtils, LCLType, UTF8Process, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Menus;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    EmptyMenu: TPopupMenu;
    StartButton: TButton;
    DriveField: TLabeledEdit;
    ToolRunner: TProcessUTF8;
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DriveFieldChange(Sender: TObject);
    procedure DriveFieldKeyPress(Sender: TObject; var Key: char);
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

procedure restrict_input(var key:char);
begin
 if not (LowerCase(key) in ['a'..'z']) then
 begin
  if ord(key)<>VK_BACK then key:=#0;
 end;

end;

procedure wipe_disk(var runner:TProcessUTF8;const disk:string);
begin
 runner.Executable:=ExtractFilePath(Application.ExeName)+'fastwiper.exe';
 runner.Parameters.Clear();
 runner.Parameters.Add(disk);
 try
  runner.Execute();
 except
  on E:Exception do ShowMessage(E.Message);
 end;

end;

procedure TMainWindow.window_setup();
begin
 Application.Title:='FAST WIPER SHELL';
 Self.Caption:='FAST WIPER SHELL 1.1';
 Self.BorderStyle:=bsDialog;
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.interface_setup();
begin
 Self.StartButton.Enabled:=False;
 Self.DriveField.MaxLength:=1;
 Self.DriveField.LabelPosition:=lpLeft;
 Self.DriveField.Text:='';
 Self.DriveField.PopupMenu:=Self.EmptyMenu;
end;

procedure TMainWindow.language_setup();
begin
 Self.StartButton.Caption:='Wipe';
 Self.DriveField.EditLabel.Caption:='A drive letter';
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
 Self.interface_setup();
 Self.language_setup();
end;

{$R *.lfm}

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
end;

procedure TMainWindow.StartButtonClick(Sender: TObject);
begin
 wipe_disk(Self.ToolRunner,Self.DriveField.Text);
end;

procedure TMainWindow.DriveFieldChange(Sender: TObject);
begin
 Self.StartButton.Enabled:=Self.DriveField.Text<>'';
end;

procedure TMainWindow.DriveFieldKeyPress(Sender: TObject; var Key: char);
begin
 restrict_input(key);
end;

end.
