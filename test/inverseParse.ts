import { parseOathTTSSavefileString, serializeOathGame } from "../src";

// Verify that a known set of savefile strings can be parsed and then serialized
// back into the original savefile string.
const testValues = [
  `030301000210Empire and Exile0002010123450CFFFFDF22FFFFFF12FFFFFF2EFFFFFF25FFFFFF05FFFFFF21FFFFFF1EFFFFFF3B3F67266B0488D6A316D5B9A87CD2A0867A9C1966D3337649B268D45401AFB0C04092610DB6937F413996943647B157B7659013A6956C519E89557306C39A64503B3213E0E2E7DBDDDCDEE6E1E9E3EDDAE8E4ECEBE5EA000407UNKNOWN`,
  `030100000710Empire and Exile00180234152011FFFFFF21FFFFFF0AFFFFFF25FFFFFF1FFFFFFF05FFFFFF2EFFFFFF2AFFFFFF4107D313A90BC301411BD4B96FBF0509399EA684173132A89AD6D223D53F107F481214751F438CA3352F2A64614B080AAFA20F1D8A727D1EC0332D55605B2C8B3E211E110C222E201A290D261502242803192B2718253004341606000E4A971CAB02E8DE`,
  `030301000210Empire and Exile0002010123450CFFFFDF22FFFFFF12FFFFFF2EFFFFFF25FFFFFF05FFFFFF21FFFFFF1EFFFFFF3B3F67266B0488D6A316D5B9A87CD2A0867A9C1966D3337649B268D45401AFB0C04092610DB6937F413996943647B157B7659013A6956C519E89557306C39A64503B3213E0E2E7DBDDDCDEE6E1E9E3EDDAE8E4ECEBE5EA000407UNKNOWN`,
  `030200000212Benis the Dinosaur000C0201234511FFDDEC0724FFED1521C8DB08FFFFFF0B0CFFFF0502FFFF25FFFFFF2BFFFFFF36D2300AD6293C33151C2E076BD30B0F0938137C321018D5231F482F1E35D41D312C118200222D140E05041734282008250D19062B1B01062A1A1216262710EAE6E0E3DCDEE1E4E9E2E7DAEBE5E8DF`,
  `030200000210The Horder Order0010000123450343FFDE1621C6DC133B86E222FFFFFF26FFFFFF0CFFFFE41EFFFFFF19FFFFFF371B6D76D4D61A330A575AAC31A6D3B32AD2D59E16746E0C249C04A510813875159BBC2545A3711769B9BB2880B11E3F5B410B60050DB619064D5C1F02992B10DDE1EAE9EBE7E6E5DAE3EDDFDBE8ECE0`,
  `03020000011FBrass Horses Tilting at Shadows00000101234514FFFFEB2BFFFFFF03FFE1FF2DFFFFFF19FFFFFF0EFFFFEC27FFFFFF1DFFFFFF3691BA1C416E4447858F8CC59640053E07A05379A79D482818316749846106ACB260C47A224E641BA4BF2BC2B089561E042E15529A590A067C2CB30C51A311DADFE5DBE9EDEAE6DDDCE7E4E8E0E3DEE2`,
];
testValues.forEach((val) => {
  const parsed = parseOathTTSSavefileString(val);
  let serialized = serializeOathGame(parsed);
  if (val !== serialized) {
    throw new Error(`not equal:\nin:\t${val}\nout:\t${serialized}`);
  }
});