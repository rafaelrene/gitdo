with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Directories;               use Ada.Directories;

procedure Gitdo is
  procedure Find_Files (Current_Directory_Path : String := Current_Directory)
  is
    Dir    : Directory_Entry_Type;
    Search : Search_Type;

    Current_Full_Name : Unbounded_String;
    Current_Base_Name : Unbounded_String;
  begin
    Start_Search
     (Search => Search, Directory => Current_Directory_Path, Pattern => "");

    Put_Line (To_Unbounded_String ("Current path: " & Current_Directory_Path));

    loop
      exit when not More_Entries (Search);

      Get_Next_Entry (Search, Dir);

      Current_Full_Name := To_Unbounded_String (Full_Name (Dir));
      Current_Base_Name :=
       To_Unbounded_String
        (Containing_Directory (To_String (Current_Full_Name)));

      Delete
       (Source  => Current_Full_Name, From => 1,
        Through => Length (Current_Base_Name) + 1);

      if Current_Full_Name /= "." and then Current_Full_Name /= ".."
       and then Current_Full_Name /= ".git"
       and then Current_Full_Name /= ".gitignore"
      then
        if Kind (Dir) = Ordinary_File then
          Put_Line (To_Unbounded_String ("-------------------------"));
          Put_Line (To_Unbounded_String ("Ordinary file: " & Full_Name (Dir)));
          Put_Line (To_Unbounded_String ("-------------------------"));
        end if;

        if Kind (Dir) = Special_File then
          Put_Line (To_Unbounded_String ("Special file: " & Full_Name (Dir)));
        end if;

        if Kind (Dir) = Directory then
          Put_Line (To_Unbounded_String ("-------------------------"));
          Put_Line (To_Unbounded_String ("Directory: " & Full_Name (Dir)));
          Put_Line (To_Unbounded_String ("-------------------------"));

          Find_Files (Full_Name (Dir));
        end if;
      end if;
    end loop;
  end Find_Files;
begin
  Find_Files;
end Gitdo;
