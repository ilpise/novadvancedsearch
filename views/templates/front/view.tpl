{**
 * 2007-2016 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2016 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file=$layout}


{block name='content'}

  <div id="main">
    {block name='page_header_container'}
      {block name='page_title'}
        <div class="page-header">
          <h1 class="page-title">{l s="Search results"}</h1>
        </div>
      {/block}
    {/block}

    {block name='page_content_container'}
      <section id="content" class="page-content">
        {block name='page_content_top'}{/block}
        {block name='page_content'}
          	{if $products}

              <div class="row">
					{include file='_partials/layout/items/item_one.tpl' class_item='col-lg-3 col-md-3' number_row=1}

				</div>

			{else}
				{l s="Sorry for the inconvenience."}
			{/if}
        {/block}
      </section>
    {/block}

    <!-- [pages] => Array ( [0] => Array ( [type] => previous [page] => 1 [clickable] => [current] => [url] => http://www.i-reuse.it/74-my-phone?page=1&q=74-my-phone )
                       [1] => Array ( [type] => page [page] => 1 [clickable] => [current] => 1 [url] => http://www.i-reuse.it/74-my-phone?page=1&q=74-my-phone )
                       [2] => Array ( [type] => page [page] => 2 [clickable] => 1 [current] => [url] => http://www.i-reuse.it/74-my-phone?page=2&q=74-my-phone )
                       [3] => Array ( [type] => page [page] => 3 [clickable] => 1 [current] => [url] => http://www.i-reuse.it/74-my-phone?page=3&q=74-my-phone )
                       [4] => Array ( [type] => spacer [page] => [clickable] => [current] => [url] => http://www.i-reuse.it/74-my-phone?q=74-my-phone )
                       [5] => Array ( [type] => page [page] => 277 [clickable] => 1 [current] => [url] => http://www.i-reuse.it/74-my-phone?page=277&q=74-my-phone )
                       [6] => Array ( [type] => next [page] => 2 [clickable] => 1 [current] => [url] => http://www.i-reuse.it/74-my-phone?page=2&q=74-my-phone )
                     ) -->


    {if count($products) < (int)Configuration::get('PS_PRODUCTS_PER_PAGE')}
      <h1>not show bottom</h1>
    {else}
      {(int)Configuration::get('PS_PRODUCTS_PER_PAGE')}
      <!-- {$urls.current_url} -->
      <hr>
      <pre>{Tools::getValue('search_query')|@print_r}</pre>
      <hr>

      <!-- Assign the get parameters inside the current url to variables -->
      {assign var=fc value=Tools::getValue('fc')}
      {assign var=module value=Tools::getValue('module')}
      {assign var=controller value=Tools::getValue('controller')}
      {assign var=orderby value=Tools::getValue('orderby')}
      {assign var=orderway value=Tools::getValue('orderway')}
      {assign var=id_category value=Tools::getValue('id_category')}
      {assign var=search_query value=Tools::getValue('search_query')}
      {assign var=submit_search value=Tools::getValue('submit_search')}

      <pre>{$search_query|@print_r}</pre>

      {assign var=url value="`$link->getModuleLink('novadvancedsearch', 'result')|escape:'html'`?fc=`$fc`&module=`$module`&controller=`$controller`&orderby=`$orderby`&orderway=`$orderway`&id_category=`$id_category`&search_query=`$search_query`&submit_search=`$submit_search`"}
      {assign var=pages value=[['type' => page, 'page' => 1, 'clickable' => '', 'current' => 1, 'url' => $url]]}
      {assign var=pagination value=['total_items' => count($products), 'items_shown_from' => 1, 'items_shown_to' => 10, 'pages' => $pages]}
      {assign var=listing value=['label'=>'Categoria: My Phone', 'products' => $products, 'pagination' => $pagination]}
      <!-- {$listing.label|@print_r} -->
      <!-- {$listing.products|@print_r} -->
      <!-- {$listing.pagination|@print_r} -->

      <pre>{$page|@print_r}</pre>
      <div class="row">
        <h1>TEST</h1>
      </div>

      <!-- taken from /themes/vinova_digimart/templates/catalog/listing/product-list.tpl -->
      {block name='product_list'}
        {include file='catalog/_partials/products.tpl' listing=$listing}
      {/block}

      <!-- taken from /themes/vinova_digimart/templates/catalog/listing/product-list.tpl -->
      {block name='product_list_bottom'}
      	{include file='catalog/_partials/products-bottom.tpl' listing=$listing}
      {/block}

    {/if}

    {block name='page_footer_container'}
      <footer class="page-footer">
        {block name='page_footer'}
          <!-- Footer content -->
        {/block}
      </footer>
    {/block}

  </div>

{/block}