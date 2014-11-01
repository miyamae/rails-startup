class CustomBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::SimpleBuilder

  def initialize(context, elements, options = {})
    super
    @options[:separator] = ''
  end

  def render_element(element)
    # truncate page title
    if element.name !~ /^</ && element.name.to_s.length > 20
      trunc = element.name[0..19].to_s
      element.name = trunc + '…'
    end
    # with microdata
    if element.path == nil
      content = compute_name(element)
    else
      content = @context.link_to_unless_current(
        @context.content_tag(:span, compute_name(element), itemprop: 'title'),
        compute_path(element), itemprop: 'url')
    end
    content = @context.content_tag(:li, content,
      itemscope: 'itemscope', itemtype: 'http://data-vocabulary.org/Breadcrumb')
  end

end
