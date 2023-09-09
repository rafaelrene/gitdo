with Ada.Text_IO;     use Ada;
with Ada.Directories; use Ada;

procedure Gitdo is
  use Ada.Directories;

  procedure Find_Files (Current_Directory_Path : String := Current_Directory)
  is
    Dir    : Directory_Entry_Type;
    Search : Search_Type;
  begin
    Start_Search
     (Search => Search, Directory => Current_Directory_Path, Pattern => "");

    Text_IO.Put_Line (Current_Directory_Path);

    loop
      exit when not More_Entries (Search);

      Get_Next_Entry (Search, Dir);

      Text_IO.Put_Line (Full_Name (Dir));

      if Kind (Dir) = Ordinary_File then
        Text_IO.Put_Line ("Ordinary file: " & Full_Name (Dir));
      end if;

      if Kind (Dir) = Special_File then
        Text_IO.Put_Line ("Special file: " & Full_Name (Dir));
      end if;

      -- if Kind (Dir) = Directory then
      --   Find_Files (Full_Name (Dir));
      -- end if;
    end loop;
  end Find_Files;
begin
  Find_Files;
end Gitdo;
