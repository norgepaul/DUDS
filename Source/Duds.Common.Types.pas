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

unit Duds.Common.Types;

interface

type
  TRenameType = (
    rtRename,
    rtSearchAndReplace
  );

  TCircularRelationshipType = (
    crNone,
    crSemiCircular,
    crCircular
  );

  TDelphiFileType = (
    ftUnknown,
    ftPAS,
    ftDPR,
    ftDPK,
    ftLIB
  );

  TUsedUnitType = (
    utInterface,
    utImplementation,
    utContains
  );

const
  LogInfo = 1;
  LogWarning = 2;
  LogError = 3;
  LogDebug = 4;

  CircularRelationshipTypeDescriptions: Array[TCircularRelationshipType] of String = (
    'None',
    'Semi Circular',
    'Circular'
  );

implementation

end.
