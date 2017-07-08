//------------------------------------------------------------------------------
//
// The contents of this file are subject to the Mozilla Public License
// Version 2.0 (the "License"); you may not use this file except in compliance
// with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Alternatively, you may redistribute this library, use and/or modify it under
// the terms of the GNU Lesser General Public License as published by the
// Free Software Foundation; either version 2.1 of the License, or (at your
// option) any later version. You may obtain a copy of the LGPL at
// http://www.gnu.org/copyleft/.
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
// the specific language governing rights and limitations under the License.
//
// Orginally released as freeware then open sourced in July 2017.
//
// The initial developer of the original code is Easy-IP AS
// (Oslo, Norway, www.easy-ip.net), written by Paul Spencer Thornton -
// paul.thornton@easy-ip.net.
//
// (C) 2017 Easy-IP AS. All Rights Reserved.
//
//------------------------------------------------------------------------------

unit Duds.Common.Parser.Pascal.Tokeniser;

interface

uses
  Classes, SysUtils;

type
  TInComment = (
    icNone,
    icDoubleSlash,
    icCurlyBracket,
    icSlashStar
  );

  TPascalToken = record
  public
    Text: String;
    Position: Integer;
  end;

  TPascalTokeniser = class(TInterfacedObject)
  private
    FPosition: Integer;
    FToken: TPascalToken;
    FCode: String;
  protected
    procedure SkipJunk;
    procedure NextChar;
    function IsJunk(var JunkText: String): Boolean;
    function Matches(const Value: String): Boolean; overload;
    function Matches(const Values: Array of String; var MatchValue: String; var Index: Integer): Boolean; overload;
    function Matches(const Values: array of String): Boolean; overload;
    function Matches(const Values: array of String; var MatchValue: String): Boolean; overload;
    function Matches(const Values: array of String; var MatchIndex: Integer): Boolean; overload;
    procedure SkipText(const Value: String);
    procedure SetCode(const Value: String);
  public
    procedure First;
    procedure Next; overload;
    procedure Next(const Delimiters: Array of String); overload;
    procedure Next(const Delimiters: Array of String; var MatchedDelimiter: String); overload;
    function Token: TPascalToken;
    function Eof: Boolean;
    function Position: Integer;
    function FindNextToken(const Token: String): Boolean; overload;
    function FindNextToken(const Tokens: array of String): Boolean; overload;

    property Code: String read FCode write SetCode;
  end;

implementation

const
  Junk: Array[0..3] of String = (
    #09,
    ' ',
    #13,
    #10
    //';'
  );

  Delimiters: Array[0..2] of String = (
    ' ',
    #13#10,
    ';'
  );

  CommentBegin: Array[0..2] of String = (
    '//',
    '{',
    '(*'
  );

  CommentEnd: Array[0..2] of String = (
    #13#10,
    '}',
    '*)'
  );

{ TPascalParser }

function TPascalTokeniser.Eof: Boolean;
begin
  Result := FPosition > length(FCode);
end;

procedure TPascalTokeniser.First;
begin
  FToken.Text := '';
  FToken.Position := 0;
  FPosition := 1;

  SkipJunk;
  Next;
end;

function TPascalTokeniser.Matches(const Value: String): Boolean;
begin
  Result := SameText(Value, copy(FCode, FPosition, length(Value)));
end;

function TPascalTokeniser.Matches(const Values: Array of String; var MatchValue: String; var Index: Integer): Boolean;
var
  i: Integer;
begin
  Result := FALSE;
  Index := 0;
  MatchValue := '';

  for i := Low(Values) to High(Values) do
    if Matches(Values[i]) then
    begin
      Result := TRUE;
      MatchValue := Values[i];
      Index := i;

      Break;
    end;
end;

function TPascalTokeniser.Matches(const Values: Array of String; var MatchValue: String): Boolean;
var
  MatchIndex: Integer;
begin
  Result := Matches(Values, MatchValue, MatchIndex);
end;

function TPascalTokeniser.Matches(const Values: Array of String; var MatchIndex: Integer): Boolean;
var
  MatchValue: String;
begin
  Result := Matches(Values, MatchValue, MatchIndex);
end;

function TPascalTokeniser.Matches(const Values: Array of String): Boolean;
var
  MatchValue: String;
  MatchIndex: Integer;
begin
  Result := Matches(Values, MatchValue, MatchIndex);
end;

function TPascalTokeniser.IsJunk(var JunkText: String): Boolean;
begin
  Result := Matches(Junk, JunkText);
end;

procedure TPascalTokeniser.SetCode(const Value: String);
begin
  FCode := Value;

  First;
end;

procedure TPascalTokeniser.SkipJunk;
var
  JunkText: String;
begin
  while (not Eof) and (IsJunk(JunkText))do
    SkipText(JunkText);
end;

function TPascalTokeniser.FindNextToken(const Token: String): Boolean;
begin
  Result := FALSE;

  while not Eof do
  begin
    if SameText(FToken.Text, Token) then
    begin
      Result := TRUE;

      Break;
    end
    else
      Next;
  end;
end;

function TPascalTokeniser.FindNextToken(const Tokens: Array of String): Boolean;
var
  i: Integer;
begin
  Result := FALSE;

  for i := Low(Tokens) to High(Tokens) do
  begin
    Result := FindNextToken(Tokens[i]);

    if Result then
      Break;
  end;
end;

procedure TPascalTokeniser.Next(const Delimiters: array of String; var MatchedDelimiter: String);
var
  InComment: TInComment;
  MatchIndex: Integer;
  MatchValue: String;
begin
  FToken.Text := '';
  FToken.Position := -1;;

  InComment := icNone;

  while not Eof do
  begin
    // Are we starting a comment
    // If we're alrady in a comment, we can|t start a new one
    if InComment = icNone then
    begin
      if Matches(Delimiters, MatchedDelimiter) then
      begin
        SkipText(MatchedDelimiter);

        Break;
      end;

      if Matches(CommentBegin, MatchValue, MatchIndex) then
      begin
        // Set the tyoe of comment we are in
        InComment := TInComment(MatchIndex + 1);

        // Increment the position past the comment identifier
        SkipText(MatchValue);
      end;
    end;

    // Only check for identifiers if we're not in a comment
    if InComment = icNone then
    begin
      if FToken.Position = -1 then
        FToken.Position := FPosition;

      FToken.Text := FToken.Text + FCode[FPosition];
    end;

    // Are we in a comment and about to exit?
    if (InComment <> icNone) and
       (Matches(CommentEnd[Integer(InComment) - 1], MatchValue, MatchIndex)) then
    begin
      // Set the tyoe of comment we are in
      InComment := icNone;

      // Increment the position past the comment identifier
      SkipText(MatchValue);

      SkipJunk;

      Continue;
    end;

    NextChar;
  end;

  SkipJunk;
end;

procedure TPascalTokeniser.Next(const Delimiters: array of String);
var
  MatchedDelimiter: String;
begin
  Next(Delimiters, MatchedDelimiter);
end;

procedure TPascalTokeniser.NextChar;
begin
  FPosition := FPosition + 1
end;

procedure TPascalTokeniser.SkipText(const Value: String);
begin
  FPosition := FPosition + length(Value);
end;

procedure TPascalTokeniser.Next;
begin
  Next(Delimiters);
end;

function TPascalTokeniser.Position: Integer;
begin
  Result := FToken.Position;
end;

function TPascalTokeniser.Token: TPascalToken;
begin
  Result := FToken;
end;

end.
