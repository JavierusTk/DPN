unit DPN.Plaza;

interface

uses
  Spring,
  Spring.Collections,

  DPN.Interfaces,
  DPN.Bloqueable;

type
  TdpnPlaza = class (TdpnBloqueable, IPlaza)
  protected
    FTokens: IList<IToken>;
    FPreCondiciones: IList<ICondicion>;
    FPreAcciones: IList<IAccion>;
    FCapacidad: Integer;
    FEventoOnTokenCountChanged: IEvent<EventoNodoPN_ValorInteger>;

    function GetOnTokenCountChanged: IEvent<EventoNodoPN_ValorInteger>;

    function GetAceptaArcosIN: Boolean; virtual;
    function GetAceptaArcosOUT: Boolean; virtual;

    function GetTokens: IReadOnlyList<IToken>; virtual;
    function GetTokenCount: Integer; virtual;

    function GetCapacidad: Integer; virtual;
    procedure SetCapacidad(const Value: integer); virtual;
  public
    constructor Create; override;

    function GetPreCondiciones: IList<ICondicion>; virtual;
    function GetPreAcciones: IList<IAccion>; virtual;

    procedure Reset; override;
    procedure Start; override;

    function LogAsString: string; override;

    procedure AddToken(AToken: IToken); virtual;
    procedure AddTokens(ATokens: TListaTokens); overload; virtual;
    procedure AddTokens(ATokens: TArrayTokens); overload; virtual;

    procedure EliminarToken(AToken: IToken); virtual;
    procedure EliminarTokens(ATokens: TListaTokens); overload; virtual;
    procedure EliminarTokens(ATokens: TArrayTokens); overload; virtual;
    procedure EliminarTokens(const ACount: integer); overload; virtual;
    procedure EliminarTodosTokens; virtual;

    procedure AddPreCondicion(ACondicion: ICondicion); virtual;
    procedure AddPreCondiciones(ACondiciones: TCondiciones); overload; virtual;
    procedure AddPreCondiciones(ACondiciones: TArrayCondiciones); overload; virtual;
    procedure EliminarPreCondicion(ACondicion: ICondicion); virtual;
    procedure EliminarPreCondiciones(ACondiciones: TCondiciones); overload; virtual;
    procedure EliminarPreCondiciones(ACondiciones: TArrayCondiciones); overload; virtual;

    procedure AddPreAccion(AAccion: IAccion); virtual;
    procedure AddPreAcciones(AAcciones: TAcciones); overload; virtual;
    procedure AddPreAcciones(AAcciones: TArrayAcciones); overload; virtual;
    procedure EliminarPreAccion(AAccion: IAccion); virtual;
    procedure EliminarPreAcciones(AAcciones: TAcciones); overload; virtual;
    procedure EliminarPreAcciones(AAcciones: TArrayAcciones); overload; virtual;

    property AceptaArcosIN: boolean read GetAceptaArcosIN;
    property AceptaArcosOUT: boolean read GetAceptaArcosIN;
    property Tokens: IReadOnlyList<IToken> read GetTokens;
    property TokenCount: Integer read GetTokenCount;
    property Capacidad: Integer read GetCapacidad write SetCapacidad;
    property PreCondiciones: IList<ICondicion> read GetPreCondiciones;

    property OnTokenCountChanged: IEvent<EventoNodoPN_ValorInteger> read GetOnTokenCountChanged;
  end;


implementation

uses
  System.SysUtils,

  DPN.Core;

{ TdpnPlaza }

procedure TdpnPlaza.AddPreAccion(AAccion: IAccion);
begin
  FPreAcciones.Add(AAccion);
end;

procedure TdpnPlaza.AddPreAcciones(AAcciones: TArrayAcciones);
begin
  FPreAcciones.AddRange(AAcciones)
end;

procedure TdpnPlaza.AddPreAcciones(AAcciones: TAcciones);
begin
  FPreAcciones.AddRange(AAcciones.ToArray)
end;

procedure TdpnPlaza.AddPreCondicion(ACondicion: ICondicion);
begin
  FPreCondiciones.Add(ACondicion);
end;

procedure TdpnPlaza.AddPreCondiciones(ACondiciones: TArrayCondiciones);
begin
  FPreCondiciones.AddRange(ACondiciones)
end;

procedure TdpnPlaza.AddPreCondiciones(ACondiciones: TCondiciones);
begin
  AddPreCondiciones(ACondiciones.ToArray)
end;

procedure TdpnPlaza.AddToken(AToken: IToken);
begin
  FTokens.Add(AToken);
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

procedure TdpnPlaza.AddTokens(ATokens: TArrayTokens);
begin
  FTokens.AddRange(ATokens);
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

procedure TdpnPlaza.AddTokens(ATokens: TListaTokens);
begin
  FTokens.AddRange(ATokens.ToArray);
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

constructor TdpnPlaza.Create;
begin
  inherited;
  FTokens         := TCollections.CreateList<IToken>;
  FPreCondiciones := TCollections.CreateList<ICondicion>;
  FPreAcciones    := TCollections.CreateList<IAccion>;
  FEventoOnTokenCountChanged := DPNCore.CrearEvento<EventoNodoPN_ValorInteger>;
end;

procedure TdpnPlaza.EliminarPreAccion(AAccion: IAccion);
begin
  FPreAcciones.Remove(AAccion)
end;

procedure TdpnPlaza.EliminarPreAcciones(AAcciones: TArrayAcciones);
begin
  FPreAcciones.RemoveRange(AAcciones)
end;

procedure TdpnPlaza.EliminarPreAcciones(AAcciones: TAcciones);
begin
  EliminarPreAcciones(AAcciones.ToArray)
end;

procedure TdpnPlaza.EliminarPreCondicion(ACondicion: ICondicion);
begin
  FPreCondiciones.Remove(ACondicion);
end;

procedure TdpnPlaza.EliminarPreCondiciones(ACondiciones: TCondiciones);
begin
  EliminarPreCondiciones(ACondiciones.ToArray)
end;

procedure TdpnPlaza.EliminarPreCondiciones(ACondiciones: TArrayCondiciones);
begin
  FPreCondiciones.RemoveRange(ACondiciones)
end;

procedure TdpnPlaza.EliminarTodosTokens;
begin
  FTokens.Clear;
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

procedure TdpnPlaza.EliminarToken(AToken: IToken);
begin
  FTokens.Remove(AToken);
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

procedure TdpnPlaza.EliminarTokens(ATokens: TListaTokens);
begin
  FTokens.RemoveRange(ATokens.ToArray);
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

procedure TdpnPlaza.EliminarTokens(ATokens: TArrayTokens);
begin
  FTokens.RemoveRange(ATokens);
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

procedure TdpnPlaza.EliminarTokens(const ACount: integer);
begin
  FTokens.DeleteRange(0, ACount);
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

function TdpnPlaza.GetAceptaArcosIN: Boolean;
begin
  Result := True;
end;

function TdpnPlaza.GetAceptaArcosOUT: Boolean;
begin
  Result := True;
end;

function TdpnPlaza.GetCapacidad: Integer;
begin
  Result := FCapacidad
end;

function TdpnPlaza.GetOnTokenCountChanged: IEvent<EventoNodoPN_ValorInteger>;
begin
  Result := FEventoOnTokenCountChanged
end;

function TdpnPlaza.GetPreAcciones: IList<IAccion>;
begin
  Result := FPreAcciones
end;

function TdpnPlaza.GetPreCondiciones: IList<ICondicion>;
begin
  Result := FPreCondiciones
end;

function TdpnPlaza.GetTokenCount: Integer;
begin
  Result := FTokens.Count
end;

function TdpnPlaza.GetTokens: IReadOnlyList<IToken>;
begin
  Result := FTokens.AsReadOnly
end;

function TdpnPlaza.LogAsString: string;
begin
  Result := inherited + '<' + ClassName + '>' + '[Capacidad]' + Capacidad.ToString + '[TokenCount]' + TokenCount.ToString;
end;

procedure TdpnPlaza.Reset;
begin
  FTokens.Clear;
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

procedure TdpnPlaza.SetCapacidad(const Value: integer);
begin
  Guard.CheckTrue(Value > 0, 'La capacidad debe ser > 0');
  FCapacidad := Value;
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

procedure TdpnPlaza.Start;
begin
  inherited;
  FEventoOnTokenCountChanged.Invoke(ID, TokenCount);
end;

end.
