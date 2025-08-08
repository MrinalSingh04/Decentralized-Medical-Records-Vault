# 🏥 Decentralized Medical Records Vault

A smart contract that enables **secure, patient-controlled access** to encrypted medical records using Ethereum. Built for privacy-first healthcare solutions. 
 
---

## 💡 What is it?
 
This contract allows **patients** to:  

- Upload **encrypted hashes** (e.g. IPFS) of their medical records.   
- **Grant or revoke access** to doctors or hospitals. 
- Ensure only **authorized parties** can retrieve their health records.   

Doctors can:

- Access patient records **only** when explicitly permitted (with expiration).
- Retrieve encrypted hashes for off-chain decryption (not stored on-chain).

---

## 🎯 Why this matters

- 🧩 **Problem:** Medical records today are fragmented across hospitals, often insecure, and patients lack true ownership.
- 🔐 **Solution:** Patients store encrypted record hashes on-chain and fully control who can view them and for how long.
- 🧠 **Use Cases:**
  - Emergency hospitals can access data temporarily.
  - Patients switching hospitals/regions can share history securely.
  - Health research (anonymized) via opt-in data vaults.

---

## ⚙️ How it Works

- `addRecord(recordHash)`: Patient adds an encrypted IPFS hash.
- `grantAccess(doctor, duration)`: Grants doctor access for `duration` seconds.
- `getPatientRecords(patient)`: Only the patient or approved doctor can retrieve the records.
- `revokeAccess(doctor)`: Revoke access anytime.

---

## 🛡️ Security & Privacy

- Only **encrypted data hashes** are stored on-chain — the raw data is off-chain (IPFS, Filecoin, etc).
- Doctors cannot access records unless explicitly authorized.
- Permissions are **time-bound and revocable**.

---

## 📜 License

MIT – Feel free to build on it for public good.
