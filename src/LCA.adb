with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := Null;
	end Initialiser;


	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
		if Taille(Sda) = 0 then
			return True;
		else
			return False;
		end if;
	end;


   function Taille (Sda : in T_LCA) return Integer is
      longueur : Integer;
   begin
      if Sda = null then
         return 0;
      else
         longueur := Taille(Sda.all.Suivant) + 1;
         return longueur;
      end if;
   end Taille;


	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
	begin
      if Est_Vide(Sda) then
         Sda := new T_Cellule;
         Sda.all := (Cle => Cle, Donnee => Donnee, Suivant => null);
      elsif Sda.all.Cle = Cle then
         Sda.all.Donnee := Donnee;
      else
         Enregistrer(Sda.all.Suivant,Cle,Donnee);
      end if;
	end Enregistrer;


	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
	begin
      if Est_Vide(Sda) then
         return False;	-- TODO : à changer
      elsif Sda.all.Cle = Cle then
         return True;
      else
         return Cle_Presente(Sda.all.Suivant, Cle);
      end if;
	end;


	function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
	begin
      if not Cle_Presente(Sda, Cle) then
         raise Cle_absente_exception;
      elsif Sda.all.Cle = Cle then
         return Sda.all.Donnee;
      else
         return La_Donnee(Sda.all.Suivant, Cle);
      end if;
	end La_Donnee;


	procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
	begin
      if not Cle_Presente(Sda, Cle) then
         raise Cle_absente_exception;
      elsif Sda.all.Cle = Cle then
         Sda := Sda.all.Suivant;
      else
         Supprimer(Sda.all.Suivant, Cle);
      end if;
	end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
	begin
      if Sda.all.Suivant = null then
         Free(Sda);
      else
         Vider(Sda);
      end if;
	end Vider;


	procedure Pour_Chaque (Sda : in T_LCA) is
	begin
      if Est_Vide(Sda) then
         null;
      else
         Traiter(Sda.All.Cle, Sda.all.Donnee);
         Pour_Chaque(Sda);
      end if;
	end Pour_Chaque;


end LCA;