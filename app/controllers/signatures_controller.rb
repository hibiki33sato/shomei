require "csv"

class SignaturesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :export]
  before_action :require_admin, only: [:index, :export]

  def create
    @signature = Signature.new(signature_params)
    if @signature.save
      redirect_to root_path(locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale)), notice: t("notice_success")
    else
      redirect_to root_path(locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale)), alert: t("alert_missing_name")
    end
  end

  def index
    @signatures = Signature.order(created_at: :desc)
  end

  def export
    signatures = Signature.order(created_at: :asc)
    csv_data = CSV.generate(encoding: "UTF-8") do |csv|
      csv << %w[No お名前（漢字） お住まいの地域 メールアドレス 応援メッセージ 日時]
      signatures.each.with_index(1) do |s, i|
        csv << [i, s.name_kanji, s.area, s.email, s.message, s.created_at.strftime("%Y/%m/%d %H:%M")]
      end
    end
    send_data "\uFEFF#{csv_data}", filename: "signatures_#{Date.today}.csv", type: "text/csv"
  end

  private

  def signature_params
    params.require(:signature).permit(:name_kanji, :area, :email, :message)
  end

  def require_admin
    redirect_to root_path, alert: t("alert_no_permission") unless current_user&.admin?
  end
end
