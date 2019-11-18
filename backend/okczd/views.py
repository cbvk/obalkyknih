import aiohttp_jinja2, jinja2, json
import requests as req
from aiohttp import web


################################################################################
#   INDEX
################################################################################

async def index(request):
    query = request.rel_url.query
    context = {'isbn':'', 'nbn':'', 'oclc':''}
    idents = {}
    if 'isbn' in query and query['isbn'] != '':
        context['isbn'] = idents['isbn'] = query['isbn']
    if 'nbn' in query and query['nbn'] != '':
        context['nbn'] = idents['nbn'] = query['nbn']
    if 'oclc' in query and query['oclc'] != '':
        context['oclc'] = idents['oclc'] = query['oclc']

    context['identsCount'] = len(idents)
    response = aiohttp_jinja2.render_template('index.html', request, context)
    response.headers['Content-Language'] = 'cs'
    return response
