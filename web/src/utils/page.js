const title = 'testp'
export default function getPageTitle(pageTitle){
    if (pageTitle) {
        return `${pageTitle} - ${title}`
    }
    return `${title}`
}