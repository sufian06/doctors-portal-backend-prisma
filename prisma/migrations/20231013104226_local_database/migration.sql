/*
  Warnings:

  - You are about to drop the column `full_name` on the `doctors` table. All the data in the column will be lost.
  - You are about to drop the column `phone_number` on the `doctors` table. All the data in the column will be lost.
  - You are about to drop the column `profile_picture` on the `medical_history` table. All the data in the column will be lost.
  - You are about to drop the column `appointment_id` on the `payment` table. All the data in the column will be lost.
  - You are about to drop the `Services` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[email]` on the table `admin` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[slot_id,service_id,slot_date,available_doctor_id]` on the table `available_services` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[phoneNumber]` on the table `doctors` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[password]` on the table `patients` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[apoointment_id]` on the table `payment` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name]` on the table `specializations` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `fullName` to the `doctors` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phoneNumber` to the `doctors` table without a default value. This is not possible if the table is not empty.
  - Added the required column `apoointment_id` to the `payment` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Services" DROP CONSTRAINT "Services_specialization_id_fkey";

-- DropForeignKey
ALTER TABLE "available_services" DROP CONSTRAINT "available_services_service_id_fkey";

-- DropForeignKey
ALTER TABLE "payment" DROP CONSTRAINT "payment_appointment_id_fkey";

-- DropIndex
DROP INDEX "available_services_slot_id_available_doctor_id_slot_date_se_key";

-- DropIndex
DROP INDEX "doctors_phone_number_key";

-- DropIndex
DROP INDEX "payment_appointment_id_key";

-- AlterTable
ALTER TABLE "doctors" DROP COLUMN "full_name",
DROP COLUMN "phone_number",
ADD COLUMN     "fullName" TEXT NOT NULL,
ADD COLUMN     "phoneNumber" TEXT NOT NULL,
ALTER COLUMN "role" DROP DEFAULT;

-- AlterTable
ALTER TABLE "medical_history" DROP COLUMN "profile_picture",
ADD COLUMN     "profile_pricture" TEXT;

-- AlterTable
ALTER TABLE "payment" DROP COLUMN "appointment_id",
ADD COLUMN     "apoointment_id" TEXT NOT NULL;

-- DropTable
DROP TABLE "Services";

-- CreateTable
CREATE TABLE "services" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "specialization_id" TEXT NOT NULL,

    CONSTRAINT "services_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "services_name_key" ON "services"("name");

-- CreateIndex
CREATE UNIQUE INDEX "admin_email_key" ON "admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "available_services_slot_id_service_id_slot_date_available_d_key" ON "available_services"("slot_id", "service_id", "slot_date", "available_doctor_id");

-- CreateIndex
CREATE UNIQUE INDEX "doctors_phoneNumber_key" ON "doctors"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "patients_password_key" ON "patients"("password");

-- CreateIndex
CREATE UNIQUE INDEX "payment_apoointment_id_key" ON "payment"("apoointment_id");

-- CreateIndex
CREATE UNIQUE INDEX "specializations_name_key" ON "specializations"("name");

-- AddForeignKey
ALTER TABLE "available_services" ADD CONSTRAINT "available_services_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_specialization_id_fkey" FOREIGN KEY ("specialization_id") REFERENCES "specializations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment" ADD CONSTRAINT "payment_apoointment_id_fkey" FOREIGN KEY ("apoointment_id") REFERENCES "appointments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
