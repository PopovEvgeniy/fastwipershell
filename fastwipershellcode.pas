unit fastwipershellcode;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, LCLType, UTF8Process, Forms, Controls,
  Graphics, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Process1: TProcessUTF8;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end;

var Form1: TForm1;

implementation

procedure wipe_disk(const passes:string;const disk:string);
begin
 Form1.Process1.Executable:=ExtractFilePath(Application.ExeName)+'fastwiper.exe';
 Form1.Process1.Parameters.Clear();
 Form1.Process1.Parameters.Add(passes);
 Form1.Process1.Parameters.Add(disk);
 try
  Form1.Process1.Execute();
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
 Form1.Caption:='FAST WIPER SHELL 0.7.8';
 Form1.BorderStyle:=bsDialog;
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
end;

procedure interface_setup();
begin
 Form1.Button1.Enabled:=False;
 Form1.LabeledEdit1.NumbersOnly:=True;
 Form1.LabeledEdit1.MaxLength:=3;
 Form1.LabeledEdit2.MaxLength:=1;
 Form1.LabeledEdit1.LabelPosition:=lpLeft;
 Form1.LabeledEdit2.LabelPosition:=Form1.LabeledEdit1.LabelPosition;
 Form1.LabeledEdit1.Text:='';
 Form1.LabeledEdit2.Text:=Form1.LabeledEdit1.Text;
end;

procedure language_setup();
begin
 Form1.Button1.Caption:='Wipe';
 Form1.LabeledEdit1.EditLabel.Caption:='Amount of wipe passes';;
 Form1.LabeledEdit2.EditLabel.Caption:='Drive letter';
end;

procedure setup();
begin
 window_setup();
 interface_setup();
 language_setup();
end;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 wipe_disk(Form1.LabeledEdit1.Text,Form1.LabeledEdit2.Text);
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
 Form1.Button1.Enabled:=(Form1.LabeledEdit1.Text<>'') and (Form1.LabeledEdit2.Text<>'');
end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
begin
 Form1.Button1.Enabled:=(Form1.LabeledEdit1.Text<>'') and (Form1.LabeledEdit2.Text<>'');
end;

procedure TForm1.LabeledEdit2KeyPress(Sender: TObject; var Key: char);
begin
 restrict_input(key);
end;

end.
