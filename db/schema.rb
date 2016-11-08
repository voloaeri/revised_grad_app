# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161108052558) do

  create_table "course_descriptions", force: :cascade do |t|
    t.integer  "number"
    t.string   "name"
    t.string   "category"
    t.string   "hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_histories", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "course_description_id"
    t.string   "grade"
    t.string   "section"
    t.integer  "faculty_id"
    t.string   "semester"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["course_description_id"], name: "index_course_histories_on_course_description_id"
    t.index ["faculty_id"], name: "index_course_histories_on_faculty_id"
    t.index ["student_id"], name: "index_course_histories_on_student_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.string   "location"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_documents_on_student_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "sectionNumber"
    t.string   "PID"
    t.string   "isAdmin"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "position"
    t.string   "semester"
    t.string   "supervisor"
    t.string   "course"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_jobs_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "PID"
    t.string   "alternativeName"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "status"
    t.string   "citizenship"
    t.string   "residency"
    t.string   "enteringStatus"
    t.string   "advisor"
    t.string   "researchArea"
    t.string   "semesterStartedCS"
    t.string   "backgroundApproved"
    t.string   "leaveExtension"
    t.string   "fundingStatus"
    t.string   "fundingEligibility"
    t.string   "intendedDegree"
    t.string   "coursesTaken"
    t.string   "hoursCompleted"
    t.string   "imageLocation"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
