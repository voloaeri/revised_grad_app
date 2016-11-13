class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :firstName
      t.string :lastName
      t.string :PID
      t.string :alternativeName
      t.string :gender
      t.string :ethnicity
      t.string :status
      t.string :citizenship
      t.string :residency
      t.string :enteringStatus
      t.string :advisor
      t.string :researchArea
      t.string :semesterStartedCS
      t.string :backgroundApproved
      t.string :leaveExtension
      t.string :fundingStatus
      t.string :fundingEligibility
      t.string :intendedDegree
      t.string :coursesTaken
      t.string :hoursCompleted
      t.string :imageLocation

      t.timestamps
    end
  end
end
