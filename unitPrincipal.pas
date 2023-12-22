unit unitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    btnNovo: TSpeedButton;
    btnEdtar: TSpeedButton;
    btnLixeira: TSpeedButton;
    bntPesquisar: TSpeedButton;
    Panel3: TPanel;
    Label2: TLabel;
    edtCodigo: TEdit;
    Label3: TLabel;
    edtNome: TEdit;
    edtEndereco: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtBairro: TEdit;
    Label6: TLabel;
    edtCidade: TEdit;
    Label7: TLabel;
    edtUf: TEdit;
    Label8: TLabel;
    edtTelefone: TEdit;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    DBGrid1: TDBGrid;
    Label9: TLabel;
    edtPesquisar: TEdit;
    Button1: TButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEdtarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure HabilitarEdits;
    procedure DesabilitarEdits;
    procedure InserirDadados;
    procedure LimparCampos;
    procedure PopularEdits;
    procedure Update;
    procedure Pesquisar;
    procedure Excluir;

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses unitDM;
{ TForm1 }

procedure TForm1.DesabilitarEdits;
begin
  edtCodigo.Enabled := false;
  edtNome.Enabled := false;
  edtEndereco.Enabled := false;
  edtBairro.Enabled :=false;
  edtCidade.Enabled := false;
  edtUf.Enabled := false;
  edtTelefone.Enabled := false;
end;

procedure TForm1.Excluir;
  var
    lID : integer;
begin
   lID := DM.QryClientes.FieldByName('codigo').AsInteger;

  with DM.QryClientes do
    begin
      close;
      SQL.Clear;
      SQL.Add('delete from clientes where codigo = :pcodigo');
      ParamByName('pcodigo').AsInteger :=  lID;
      ExecSQL;
      MessageDlg('Registro deletado com sucesso', mtInformation, [mbOK], 0);
      Pesquisar
    end;
end;

procedure TForm1.HabilitarEdits;
begin
  edtCodigo.Enabled := false;
  edtNome.Enabled := true;
  edtEndereco.Enabled := true;
  edtBairro.Enabled :=true;
  edtCidade.Enabled := true;
  edtUf.Enabled := true;
  edtTelefone.Enabled := true;
end;

procedure TForm1.InserirDadados;
begin
  with DM.QryClientes do
    begin
      close;
      SQL.Clear;
      SQL.Add('insert into clientes (nome, endereco, bairro, cidade, uf, telefone) values ');
      SQL.Add('(:pnome, :pendereco, :pbairro, :pcidade, :puf, :ptelefone)');
      ParamByName('pnome').AsString := edtNome.Text;
      ParamByName('pendereco').AsString := edtEndereco.Text;
      ParamByName('pbairro').AsString := edtBairro.Text;
      ParamByName('pcidade').AsString := edtCidade.Text ;
      ParamByName('puf').AsString := edtUf.Text;
      ParamByName('ptelefone').AsString := edtTelefone.Text;
      ExecSQL;
      LimparCampos;
      Pesquisar;
    end;
end;

procedure TForm1.LimparCampos;
begin
  edtCodigo.Text := '';
  edtNome.Text := '';
  edtEndereco.Text := '';
  edtBairro.Text := '';
  edtCidade.Text := '';
  edtUf.Text := '';
  edtTelefone.Text := '';
end;

procedure TForm1.Pesquisar;
begin
  DM.QryClientes.Close;
  DM.QryClientes.SQL.Clear;

  DM.QryClientes.SQL.Text := 'select * from clientes where nome like ' +  QuotedStr('%' + edtPesquisar.Text + '%') ;
  DM.QryClientes.Open();
end;

procedure TForm1.PopularEdits;
begin
  edtCodigo.Text        := DM.QryClientes.FieldByName('CODIGO').AsString;
  edtNome.Text          := DM.QryClientes.FieldByName('NOME').AsString;
  edtEndereco.Text      := DM.QryClientes.FieldByName('ENDERECO').AsString;
  edtBairro.Text := DM.QryClientes.FieldByName('BAIRRO').AsString;
  edtCidade.Text        := DM.QryClientes.FieldByName('CIDADE').AsString;
  edtUf.Text    := DM.QryClientes.FieldByName('UF').AsString;
  edtTelefone.Text    := DM.QryClientes.FieldByName('TELEFONE').AsString;

end;

procedure TForm1.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja deleta um registro?,' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes then;
  Excluir;
end;

procedure TForm1.btnNovoClick(Sender: TObject);
begin
  if MessageDlg('Deseja criar um novo registro?,' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes then;
  HabilitarEdits;
end;

procedure TForm1.btnEdtarClick(Sender: TObject);
begin
if MessageDlg('Deseja editar o registo: ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
HabilitarEdits;
PopularEdits;
end;

procedure TForm1.btnSalvarClick(Sender: TObject);
begin
  if MessageDlg('Deseja gravar o registro:?', mtConfirmation, [mbYes, mbNo],0) = mrYes then;
    begin
       if trim(edtCodigo.Text) = '' then
            InserirDadados
       else
       Update;
      LimparCampos;
      DesabilitarEdits;
      Pesquisar;
    end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Pesquisar;
end;

procedure TForm1.Update;
begin
   with DM.QryClientes do
    begin
      close;
      SQL.Clear;
      SQL.Add('update clientes        '+
               '  set nome = :pnome,    '+
               '  endereco = :pendereco,'+
               '  bairro = :pbairro,    '+
               '  cidade = :pcidade,    '+
               '  uf = :puf,            '+
               '  telefone = :ptelefone,'+
               '  where codigo  = :pcodigo');
      ParamByName('pcodigo').AsInteger := StrToInt(edtCodigo.Text);
      ParamByName('pnome').AsString := edtNome.Text;
      ParamByName('pendereco').AsString := edtEndereco.Text;
      ParamByName('pbairro').AsString := edtBairro.Text;
      ParamByName('pcidade').AsString := edtCidade.Text;
      ParamByName('puf').AsString := edtUf.Text;
      ParamByName('ptelefone').AsString := edtTelefone.Text;
      ExecSQL;

    end;
end;

end.
