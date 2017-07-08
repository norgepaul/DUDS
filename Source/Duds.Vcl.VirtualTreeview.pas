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

unit Duds.Vcl.VirtualTreeview;

interface

uses
  VirtualTrees,

  Duds.Vcl.HourGlass;

type
  TVirtualTreeHelper = class helper for TVirtualStringTree
  private
    procedure InternalExpandCollapse(const Node: PVirtualNode; const Expand: Boolean);
  public
    procedure AutoFitColumns(Animated: Boolean = FALSE; SmartAutoFitType: TSmartAutoFitType = smaUseColumnOption; RangeStartCol: Integer = NoColumn; RangeEndCol: Integer = NoColumn; IncludeHeader: Boolean = TRUE);
    procedure SelectNodeEx(const Node: PVirtualNode; const ScrollNodeIntoView: Boolean = True; const Centre: Boolean = False);
    procedure ExpandAll(const Node: PVirtualNode = nil);
    procedure CollapseAll(const Node: PVirtualNode = nil);
  end;

implementation

{ TVirtualTreeHelper }

procedure TVirtualTreeHelper.SelectNodeEx(const Node: PVirtualNode;
  const ScrollNodeIntoView: Boolean; const Centre: Boolean);
begin
  ClearSelection;

  if Assigned(Node) then
  begin
    FocusedNode := Node;
    Selected[Node] := TRUE;

    if ScrollNodeIntoView then
      ScrollIntoView(Node, Centre);
  end;
end;

procedure TVirtualTreeHelper.CollapseAll(const Node: PVirtualNode);
begin
  InternalExpandCollapse(Node, False);
end;

procedure TVirtualTreeHelper.InternalExpandCollapse(const Node: PVirtualNode; const Expand: Boolean);

  procedure RecNode(const ANode: PVirtualNode);
  var
    StepNode: PVirtualNode;
  begin
    if ANode <> nil then
    begin
      Expanded[ANode] := Expand;

      StepNode := ANode.FirstChild;

      while StepNode <> nil do
      begin
        RecNode(StepNode);

        StepNode := StepNode.NextSibling;
      end;
    end;
  end;

begin
  BeginUpdate;
  try
    if Node = nil then
    begin
      RecNode(RootNode);
    end
    else
    begin
      RecNode(Node);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TVirtualTreeHelper.ExpandAll(const Node: PVirtualNode);
begin
  InternalExpandCollapse(Node, True);
end;

procedure TVirtualTreeHelper.AutoFitColumns(Animated: Boolean; SmartAutoFitType: TSmartAutoFitType;
      RangeStartCol: Integer; RangeEndCol: Integer; IncludeHeader: Boolean);
var
  i, TextW: Integer;
begin
  // Fit the column text
  Header.AutoFitColumns(Animated, SmartAutoFitType, RangeStartCol,RangeEndCol);

  // Fit the header text
  for i := 0 to pred(Header.Columns.Count) do
  begin
    TextW := Canvas.TextWidth(Header.Columns[i].Text) + 15;

    if (TextW > Header.Columns[i].Width) and (TextW < Header.Columns[i].MaxWidth) and (TextW > Header.Columns[i].MinWidth) then
      Header.Columns[i].Width := TextW;
  end;
end;

end.
