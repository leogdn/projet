with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Command_Line;     use Ada.Command_Line;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with LCA;

procedure lire_table is

   package Table is new LCA(T_Destination => Unbounded_String,
                              T_Masque      => Unbounded_String,
                            T_Interface   => Unbounded_String);

   use Table;

   procedure Lire_ligne(Ligne : in String ; Table : in out T_LCA) is
      k,n : Integer ;
      Element : Array (1..3) of Unbounded_String ;
   begin
      k := 1;
      -- n := Ligne'range ;
      -- Str_Ligne := To_String(Ligne) ;
      Element(1) := To_Unbounded_String("");
      Element(2) := To_Unbounded_String("");
      Element(3) := To_Unbounded_String("");
      for l in Ligne'range loop
         if not(Ligne(l) = ' ') then
            Append(Element(k),Ligne(l));
         elsif ((l = 1) or not(Ligne(l-1) = ' ')) then
            k := k + 1;
         else
            null;
         end if;
      end loop;
      Enregistrer(Table,Element(1),Element(2),Element(3));
   end Lire_ligne;
   
   procedure Afficher(Destination : in Unbounded_String ; Masque : in Unbounded_String ; D_Interface : in Unbounded_String) is
   begin
      Put_Line(To_String(Destination)&" : "&To_String(Masque)&" : "&To_String(D_Interface));
   end Afficher;
   
   procedure Afficher_lca is new Table.Pour_Chaque(Traiter => Afficher);

   Table_routage : T_LCA;

   Ligne : String := "147.127.127.0 255.255.255.0 eth0";
   Ligne2 : String := "147.128.0.0   255.255.0.0     eth1";

begin
   Initialiser(Table_routage);
   Lire_ligne(Ligne => Ligne,
              Table => Table_routage);
   Lire_ligne(Ligne => Ligne2,
              Table => Table_routage);
   Afficher_lca(Table_routage);
end lire_table;
