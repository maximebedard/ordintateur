module ApplicationHelper
  def errors_summary(record)
    render(
      partial: "shared/errors_summary",
      locals: { record: record },
    )
  end
end
