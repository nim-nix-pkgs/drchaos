{
  description = ''A powerful and easy-to-use fuzzing framework in Nim for C/C++/Obj-C targets'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-drchaos-v0_1_6.flake = false;
  inputs.src-drchaos-v0_1_6.ref   = "refs/tags/v0.1.6";
  inputs.src-drchaos-v0_1_6.owner = "status-im";
  inputs.src-drchaos-v0_1_6.repo  = "nim-drchaos";
  inputs.src-drchaos-v0_1_6.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-drchaos-v0_1_6"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-drchaos-v0_1_6";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}