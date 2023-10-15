/*
  Warnings:

  - Added the required column `specialization_id` to the `Services` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Services" ADD COLUMN     "specialization_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "medical_history" ALTER COLUMN "profile_picture" DROP NOT NULL,
ALTER COLUMN "medical_history" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Services" ADD CONSTRAINT "Services_specialization_id_fkey" FOREIGN KEY ("specialization_id") REFERENCES "specializations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
