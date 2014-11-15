module ApplicationHelper

  # See also: http://hajimete-ruby.jugem.jp/?eid=84
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def hbr(str)
    h(str).gsub(/(\r\n?)|(\n)/, "<br>").html_safe
  end

  def input_field(label, controls, help=nil)
    if controls.is_a?(Array)
      inp_html = %{<ul class="inputs-list">}
      controls.each do |ctl|
        inp_html += %{<li><label>#{ctl}</label></li>}
      end
      inp_html += %{</ul>}
    else
      inp_html = controls
    end
    if help
      inp_html += raw %{<span class="help-block">#{help}</span>}
    end
    label_html = label =~ /<label/ ? label : "<label>#{label}</label>"
    label_html.gsub!(/(<label)/, '\1 class="control-label"') unless label_html =~ /control\-label/
    html = %{<div class="control-group">#{label_html}} +
      %{<div class="controls">#{inp_html}</div></div>}
    raw html
  end

  # Change Userモード？
  def change_user?
    session[:su] && session[:su] != current_user.email
  end

end


class ActionView::Helpers::FormBuilder

  # Bootstrap Form用の入力フィールド
  def bootstrap_field(label, controls, help=nil)
    if controls.is_a?(Array)
      inp_html = %{<ul class="inputs-list">}
      controls.each do |ctl|
        inp_html += %{<li><label>#{ctl}</label></li>}
      end
      inp_html += %{</ul>}
    else
      inp_html = controls
    end
    if help
      inp_html += %{<span class="help-block">#{help}</span>}.html_safe
    end
    label_str = label.is_a?(String) ? label : label(label)
    label_html = label_str =~ /<label/ ? label_str : "<label>#{label}</label>"
    label_html.gsub!(/(<label)/, '\1 class="col-sm-3 control-label"') unless label_html =~ /control\-label/
    html = %{<div class="form-group">#{label_html}} +
      %{<div class="col-sm-9">#{inp_html}</div></div>}
    html.html_safe
  end

  def hidden_filed_dt(params, k)
    tag = hidden_field(k)
    if params["#{k}(1i)"]
      r = []
      r << params["#{k}(1i)"] if params["#{k}(1i)"]
      r << params["#{k}(2i)"] if params["#{k}(2i)"]
      r << params["#{k}(3i)"] if params["#{k}(3i)"]
      v = r.join('/')
      tag.gsub!(/(name=)/, "value=\"DT:#{ERB::Util.h v}\" \\1")
    end
    tag
  end

  def get_args(args)
    args2 = {class: 'form-control'}
    args2.merge!(args.first) unless args.empty?
    args2.delete(:help)
    args2
  end

  # hiddenタグを使った状態遷移
  # 例）<%= f.hidden_transport(params[:user]) %>
  def hidden_transport(params)
    html = ""
    params.each do |k, v|
      kk = k.gsub(/\(.*?\)$/,"")
      if v.is_a?(Array)
        if v.size <= 1
          tag = hidden_filed_dt(params, kk)
          tag.gsub!(/value=\".*?\"/, "value=\"\"")
          html += tag
        else
          v.each do |vv|
            tag = hidden_filed_dt(params, kk)
            unless tag =~ /name=\".*?\[\]\"/
              tag.gsub!(/(name=\".*?)\"/, '\1[]"')
              tag.gsub!(/value=\".*?\"/, "value=\"#{ERB::Util.h vv}\"")
            end
            html += tag
          end
        end
      else
        html += hidden_filed_dt(params, kk)
      end
    end
    html.html_safe
  end

  # テキストボックス
  def bootstrap_text(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    bootstrap_field(label(name), text_field(name, *[get_args(args)]), title)
  end

  # パスワードフィールド
  def bootstrap_password(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    bootstrap_field(label(name), password_field(name, *[get_args(args)]), title)
  end

  # ファイルフィールド
  def bootstrap_file(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    bootstrap_field(label(name), file_field(name, *[get_args(args)]), title)
  end

  # 画像フィールド
  def bootstrap_paperclip(name, size, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    fields = %{<img src="#{object.send(name, size)}" class="img-responsive img-thumbnail">}
    if object.send(name).file?
      fields += %{ <label style="font-weight: normal;">} +
        %{<input type="checkbox" name="remove_images[]" value="#{name}"> 削除</label>}
    end
    fields += file_field(name)
    bootstrap_field(label(name), fields, title)
  end

  # テキストエリア
  def bootstrap_textarea(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    bootstrap_field(label(name), text_area(name, *[get_args(args)]), title)
  end

  # 日付カレンダー選択
  def bootstrap_datepicker(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    value = object.send(name)
    bootstrap_field(label(name),
      text_field(name, {
        value: value.blank? ? '' : value.strftime('%Y-%m-%d'),
        class: 'form-control datepicker'}), title)
  end

  # 日時カレンダー選択
  def bootstrap_datetimepicker(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    value = object.send(name)
    bootstrap_field(label(name),
      text_field(name, {
        value: value.blank? ? '' : value.strftime('%Y-%m-%d %H:%M'),
        class: 'form-control datetimepicker'}), title)
  end

  # ドロップダウンリスト
  def bootstrap_select(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    #bootstrap_field(label(name), select(name, *[get_args(args)]), title)
    if args.size == 1
      bootstrap_field(label(name), select(name, *args, {}, {class: 'form-control'}), title)
    else
      bootstrap_field(label(name), select(name, *args, {class: 'form-control'}), title)
    end
  end

  # チェックボックス
  def bootstrap_checkbox(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    html = check_box(name, *args)
    if args[0] && args[0][:label]
      html = '<div class="checkbox"><label>' +
        html + ' ' + args[0][:label] + '</label></div>'
    else
      html = '<div class="checkbox">' + html + '</label></div>'
    end
    bootstrap_field(label(name), html, title)
  end

  # 静的コントロール
  def bootstrap_static(name, html, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    html = '<p class="form-control-static">' +  html + '</p>'
    bootstrap_field(label(name), html, title)
  end

  # 複数チェックボックス
  def bootstrap_collection_checkboxes(name, *args)
    title = args.last.is_a?(Hash) && args.last[:help] ? args.last[:help] : nil
    html = collection_check_boxes(name, *args) { |b|
      %{<span class="checkbox-item">#{b.check_box} #{b.label}</span> }.html_safe
    }
    html = %{<div class="collection-checkboxes form-control-static">#{html}</div>}
    bootstrap_field(label(name), html, title)
  end

  # 保存/キャンセルボタン
  def bootstrap_submit(caption='保存')
    html = '<hr>'
    html += '<div class="form-group">'
    html += '<div class="col-sm-offset-3 col-sm-9">'
    html += submit(caption, class: 'btn btn-primary', style: 'width:100px;')
    html += '</div>'
    html += '</div>'
    html.html_safe
  end
  def bootstrap_submits(caption='保存')
    html = '<hr>'
    html += '<div class="form-group">'
    html += '<div class="col-sm-offset-3 col-sm-9">'
    html += submit(caption, class: 'btn btn-primary', style: 'width:100px;')
    html += ' '
    html += submit(I18n.t('helpers.submit.cancel'),
      name: 'cancel', class: 'btn btn-default', style: 'width:100px;')
    html += '</div>'
    html += '</div>'
    html.html_safe
  end

end
