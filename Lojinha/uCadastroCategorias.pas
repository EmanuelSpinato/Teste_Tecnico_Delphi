unit uCadastroCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TfmCadastroCategorias = class(TfmCadastroBase)
    qrDadosDESCRICAO: TStringField;
    qrDadosID: TFDAutoIncField;
    Label1: TLabel;
    edId: TDBEdit;
    Label2: TLabel;
    edDescricao: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    procedure BeforeEdit; override;  // Sobrescreve o m�todo BeforeEdit da classe base
    procedure BeforePost; override;  // Implementa��o do BeforePost (se necess�rio)
    function ValidarObrigatorios: boolean; override;
  public
    { Public declarations }
  end;

var
  fmCadastroCategorias: TfmCadastroCategorias;

implementation

{$R *.dfm}

{ TfmCadastroCategorias }

procedure TfmCadastroCategorias.BeforeEdit;
begin
  // Aqui voc� pode adicionar a l�gica necess�ria antes de editar os dados
  ShowMessage('Antes de editar a categoria!');
end;

procedure TfmCadastroCategorias.BeforePost;
begin
  // L�gica a ser executada antes de salvar o registro
  if Trim(edDescricao.Text) = '' then
  begin
    ShowMessage('A descri��o n�o pode estar vazia!');
    Abort;  // Cancela a a��o de salvar se a valida��o falhar
  end;

  // Caso precise, adicione mais valida��es ou modifica��es no registro antes do post
end;

procedure TfmCadastroCategorias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fmCadastroCategorias := nil;
end;

function TfmCadastroCategorias.ValidarObrigatorios: boolean;
begin
  if Trim(edDescricao.Text) = '' then
  begin
    ShowMessage('Informe a descri��o.');
    edDescricao.SetFocus;
    Exit(false);
  end;

  Result := inherited ValidarObrigatorios;
end;

end.

