# README: User Transaction & Behavior Analysis

## SQL Files

### 1. `transaction_user_card_detail.sql`

**Tujuan:**  
Membuat tabel gabungan yang menyatukan data transaksi, data kartu, dan data pengguna untuk analisis perilaku lebih lanjut.

**Deskripsi Proses:**
- Mengambil data dari tiga tabel:
  - `transactions_data` → data transaksi
  - `cards_data` → data kartu
  - `users_data` → data pengguna
- Melakukan `LEFT JOIN` berdasarkan `card_id` dan `client_id`
- Menyaring transaksi dengan nilai `amount` yang valid dan positif
- Menambahkan atribut pengguna dan kartu ke setiap baris transaksi

**Output Table:**  
`users_dataset.transaction_user_card_detail`

**Kolom Utama:**
- `id`, `date`, `amount`, `card_id`, `user_id`
- `card_type`, `credit_limit`, `expires`
- `gender`, `age`, `income`, `credit_score`

---

### 2. `user_behavior_exec_view.sql`

**Tujuan:**  
Membuat view agregat untuk menganalisis perilaku pengguna berdasarkan waktu, usia, tipe kartu, dan skor kredit.

**Deskripsi Proses:**
- Mengambil data dari `transaction_user_card_detail`
- Menambahkan label waktu (bulan, tahun)
- Membuat segmentasi:
  - Usia → `age_group`
  - Tipe kartu → `card_type_label`
  - Skor kredit → `credit_score_group`
- Menghitung metrik agregat:
  - Jumlah transaksi
  - Total dan rata-rata nilai transaksi
  - Jumlah pengguna unik

**Output View:**  
`users_dataset.user_behavior_exec_view`

**Kolom Utama:**
- `transaction_month_date`, `transaction_month_label`, `transaction_year`
- `age_group`, `card_type_label`, `credit_score_group`
- `total_transactions`, `total_amount`, `avg_amount`, `unique_users`

---

## Cara Menjalankan

1. Buka BigQuery Console
2. Jalankan query pertama untuk membuat tabel `transaction_user_card_detail`
3. Jalankan query kedua untuk membuat view `user_behavior_exec_view`
4. Gunakan view ini sebagai sumber data untuk dashboard atau analisis lanjutan

---

## Visualisasi

- **Time Series Chart** → total transaksi per bulan
- **Bar Chart** → distribusi transaksi berdasarkan `age_group` atau `card_type_label`
- **Pivot Table** → kombinasi `credit_score_group` dan `avg_amount`
- **KPI Cards** → total transaksi, total amount, unique users
