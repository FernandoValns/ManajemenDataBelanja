program ManajemenDaftarBelanja;

uses crt;

type
  totalbarang = record
    nama: string;
    harga: real;
    pembeli: string;
  end;
var
  daftarBelanja: array[1..100] of totalbarang;
  jumlahbarang: integer = 0;

// Prosedur untuk menambahkan barang ke daftar belanja
procedure Tambahbarang(nama, pembeli: string; harga: real);
begin
  if jumlahbarang < 100 then
  begin
    inc(jumlahbarang); // increment digunakan untuk menambah barang seperti nama harga dan pembeli 
    daftarBelanja[jumlahbarang].nama := nama; 
    daftarBelanja[jumlahbarang].harga := harga;
    daftarBelanja[jumlahbarang].pembeli := pembeli;
  end
  else
    writeln('Daftar belanja penuh.');
end;

// Prosedur untuk menampilkan daftar belanja
procedure TampilkanDaftar;
var
  i, j: integer;
  totalHarga: real = 0.0;
  pembeliList: array[1..100] of string;
  pembeliTotal: array[1..100] of real;
  pembeliCount: integer = 0;
  found: boolean;
begin
  if jumlahbarang = 0 then
    writeln('Daftar belanja kosong.')// jika barang kosong maka akan keluar ini
  else
  begin
    writeln('Daftar Belanja:');
    for i := 1 to jumlahbarang do
    begin
      writeln(i, '. ', daftarBelanja[i].nama, ' - Rp', daftarBelanja[i].harga:0:2, ' (pembeli: ', daftarBelanja[i].pembeli, ')');
      totalHarga := totalHarga + daftarBelanja[i].harga; // penunjuk pada semua barang yagn sudah ditambah

      // Tambahkan total harga per pembeli sehingga bisa dipisahkan sesuai pembeli barang masing masing
      found := false;
      for j := 1 to pembeliCount do
      begin
        if pembeliList[j] = daftarBelanja[i].pembeli then
        begin
          pembeliTotal[j] := pembeliTotal[j] + daftarBelanja[i].harga;
          found := true;
          break;
        end;
      end;

      if not found then // harga keseluruhan dari pembeli(gabungan antar pembeli memasukan data per masing masing lalu satukan)
      begin
        inc(pembeliCount);
        pembeliList[pembeliCount] := daftarBelanja[i].pembeli;
        pembeliTotal[pembeliCount] := daftarBelanja[i].harga;
      end;
    end;

    writeln('Total harga per pembeli:');
    for i := 1 to pembeliCount do
    begin
      writeln('- ', pembeliList[i], ': Rp', pembeliTotal[i]:0:2);
    end;

    writeln('Total harga Keseluruhan: Rp', totalHarga:0:2);
  end;
end;

// Fungsi untuk menghapus barang dari daftar belanja
function Hapusbarang(index: integer): boolean;
var
  i: integer;
begin
  if (index < 1) or (index > jumlahbarang) then
  begin
    Hapusbarang := false;
  end
  else
  begin
    for i := index to jumlahbarang - 1 do
      daftarBelanja[i] := daftarBelanja[i + 1];
    dec(jumlahbarang);
    Hapusbarang := true;
  end;
end;

// Program utama
var
  pilihan: integer;
  namabarang, pembelibarang, ulangTambah, ulangHapus: string;
  hargabarang: real;
  index: integer;

begin
  clrscr;

  repeat
    writeln('=== Manajemen Daftar Belanja ===');// menu untuk program semua akan kemabli ke loop disini
    writeln('1. Tambah barang');
    writeln('2. Hapus barang');
    writeln('3. Tampilkan Daftar');
    writeln('4. Keluar');
    write('Pilih menu: ');
    readln(pilihan);

    case pilihan of 
      1: begin
           repeat
             write('Masukkan nama pembeli barang: ');
             readln(pembelibarang);
             write('Masukkan nama barang: ');
             readln(namabarang);
             write('Masukkan harga barang: ');
             readln(hargabarang);
             Tambahbarang(namabarang, pembelibarang, hargabarang);

             write('Apakah Anda ingin menambah barang lagi? (Y/T): ');
             readln(ulangTambah);
           until (ulangTambah = 'T') or (ulangTambah = 't'); // pengulangan untuk program tambahan barang
           writeln('Kembali ke menu belanja');
           writeln('-------------------------------');
         end;

      2: begin
           if jumlahbarang = 0 then// jika barang kong maka akan mengulang ke dalam menu
             writeln('Maaf, barang kosong. Tolong tambahkan barang dulu.')
           else
           begin
             repeat
               write('Masukkan nomor barang yang akan dihapus: ');
               readln(index);
               if Hapusbarang(index) then
                 writeln('barang berhasil dihapus.')
               else
                 writeln('Nomor barang tidak valid.');

               write('Apakah Anda ingin menghapus barang lagi? (Y/T): ');
               readln(ulangHapus);
             until (ulangHapus = 'T') or (ulangHapus = 't'); // pengulangan untuk penghapusan per barang
           end;
           writeln('Kembali ke menu belanja');
           writeln('-------------------------------');
         end;

      3: TampilkanDaftar; // penampil dalam program

      4: writeln('Keluar dari program...');

      else
        writeln('Pilihan tidak valid.'); // jika memilih yang lain maka tidak valid dan mengulang
    end;

    writeln;
  until pilihan = 4; // pengulangan akan terus memilih hingga memilih keluar atau nomor 4
end.
